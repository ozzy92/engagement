require 'set'
include ActionView::Helpers::NumberHelper

module EngagementRequestsHelper

  # I'm presuming this module is for mix in functions
  # I'm going to use it for my validations, this is mixed into the model
  # The point of this function is to be as annoying as possible, and prevent success
  # A demo that is designed to be annoying may have been a bad idea!
  def validate
    # assume we are invalid, unless we manage to pass everything
    self.status = :validation
    self.validations = nil

    if self.validate_required
      # perform other validations
      self.validate_contacts
      self.validate_project
      self.validate_funding
      self.validate_time_to_market

      if self.validations.nil?
        # success!  miraculous!
        self.status = :submitted
      else
        # shuffle and truncate errors
        validations = self.validations.split('|')
        validations.shuffle!
        if validations.size > 5
          validations = validations[0...5]
          validations.append('More than 5 validation errors. Fix errors to see further validations')
        end
        self.validations = validations.join('|')
      end
    end
  end

  # make sure all user entered fields are filled with something
  def validate_required
    [
        :project_name,
        :status,
        :requester_id,
        :subject_expert_id,
        :sponsor_id,
        :vision,
        :goal,
        :description,
        :scope,
        :advice_required,
        :program_id,
        :train_id,
        :funding_method,
        :cost_center,
        :funding_status,
        :budget_allocated,
        :priority,
        :start_date,
        :end_date,
        :risk_rating,
        :risks,
        :projected_revenue,
    ].each do |field|
      if self.attributes[field.to_s].nil?
        # intentionally vague!
        add_validation 'All fields are required to perform further validations'
        return false
      end
    end
    true
  end

  # make sure employees meet random requirements
  def validate_contacts
    # we assume they are set at this point
    # contacts are unique
    contacts = [ self.requester, self.subject_expert, self.sponsor ]
    if Set.new(contacts).length != contacts.length
      add_validation 'All contacts must be unique'
    end

    # sponsor should be higher than expert, and expert higher than requester
    # ranks are reversed, rank 1 is top (board chairman)
    if self.sponsor.title.rank >= self.subject_expert.title.rank
      add_validation 'Sponsor should be a higher rank than the Subject Expert'
    end
    if self.subject_expert.title.rank >= self.requester.title.rank
      add_validation 'Subject Expert should be a higher rank than the Requester'
    end

    # contacts are co-located!
    if Set.new(contacts.map { |contact| contact.office.mail_code }).length > 1
      add_validation 'All contacts should be co-located'
    end
  end

  # validates the project description fields.
  def validate_project

    # project name should be 10 to 30 length, and 5 words or fewer
    validate_length_words 'Project Name', self.project_name, 10, 30, 0, 5

    # vision should be 1 sentence
    validate_sentences_length 'Vision', self.vision, 30, 100, 1

    # goal should be 1 sentence
    validate_sentences_length 'Goal', self.goal, 30, 100, 1

    # description, and scope should be 5 sentences!
    validate_sentences_length 'Description', self.description, 100, 500, 5
    validate_sentences_length 'Scope', self.scope, 100, 500, 5

    # advice needed
    validate_sentences_length 'Advice Required', self.advice_required, 50, 200, 3

    # randomize program and train complaints!
    validate_random_day 'Program', self.program.name
    validate_random_day 'Train', self.train.name
  end

  # validate the funding section
  def validate_funding
    # randomize funding method!
    validate_random_day 'Funding Method', EngagementRequest::FUNDING_METHODS[self.funding_method]

    # sponsor is funding it!
    if self.cost_center != self.sponsor.department.cost_center
      add_validation "Cost Center should match the Sponsor's cost center"
    end

    # detailed estimate must be funding approved!
    if self.detailed_estimate? && ! (self.approved? || self.budget?)
      add_validation EngagementRequest::ENGAGEMENT_TYPES[self.engagement_type] + ' must have budget ' +
                         EngagementRequest::FUNDING_STATUSES["approved"] + ' or ' +
                         EngagementRequest::FUNDING_STATUSES["budget"]
    end
    # scheduling or rescue must have budget!
    if (self.scheduling? || self.rescue?) && ! self.budget?
      add_validation EngagementRequest::ENGAGEMENT_TYPES[self.engagement_type] + ' must have ' +
                         EngagementRequest::FUNDING_STATUSES["budget"]
    end

    # must have a decent budget!
    if self.budget_allocated < 100_000
      add_validation 'Projects with a budget of less than $100,000 are not accepted'
    end
  end

  LEAD_TIME = {
      "high_priority" => 30,
      "medium_priority" => 60,
      "low_priority" => 90
  }

  RISK_REWARD = {
      "high_risk" => 5_000_000,
      "medium_risk" => 2_000_000,
      "low_risk" => 500_000,
  }

  # validate time to market values!
  def validate_time_to_market
    # lead time based on priority!
    today = Date.today
    days = (self.start_date - today).to_i
    if days < LEAD_TIME[self.priority]
      add_validation 'Start date must be at least ' + LEAD_TIME[self.priority].to_s + ' days in advance for ' +
                         EngagementRequest::PRIORITIES[self.priority] + ' priority'
    end

    # 30 day minimum!
    length = (self.end_date - self.start_date).to_i
    if length < 30
      add_validation 'Projects with a length of less than 30 days will not be considered'
    end

    # must start on a Monday and end on a Friday
    if self.start_date.wday != 1
      add_validation 'Start Date must be a Monday'
    end
    if self.end_date.wday != 5
      add_validation 'End Date must be a Friday'
    end

    # cost reduction projects!
    cost_reduction = ['Operations Streamlining', 'Manufacturing Efficiency'].include? self.program.name
    if cost_reduction && self.projected_revenue != 0
      add_validation self.program.name + ' is not expected to generate revenue'
    end
    if cost_reduction && ! self.low_risk?
      add_validation self.program.name + ' projects must be low risk'
    end

    # potential profit!
    profit = self.projected_revenue - self.budget_allocated
    if ! cost_reduction && profit < RISK_REWARD[self.risk_rating]
      add_validation EngagementRequest::RISK_RATINGS[self.risk_rating] +
                         ' risk projects should be expected to produce at least ' +
                         number_to_currency(RISK_REWARD[self.risk_rating]) + ' profit'
    end

    # risks should be defined! 5 sentences!
    validate_sentences_length 'Risks', self.risks, 100, 500, 5
  end

  # takes a random chance to invalidate a selection for day of week
  def validate_random_day(name, value)
    now = Time.new
    if rand(0...7) == now.wday
      add_validation name + ' ' + value + ' is not considered on ' + now.strftime("%A") + '.  Try another time'
    end
  end

  def validate_length_words(name, value, min_length, max_length, min_words, max_words)
    validate_words name, value, min_words, max_words
    validate_length name, value, min_length, max_length
  end

  def validate_words(name, value, min_words, max_words)
    words = value.split
    word_count = words.size
    word_length = words.map { |word| word.length }.sum / words.size
    if word_count < min_words
      add_validation name + ' should be at least ' + min_words.to_s + ' words'
    elsif word_count > max_words
      add_validation name + ' should be fewer than ' + max_words.to_s + ' words'
    elsif word_length < 5
      add_validation name + ' should have an average word length of 5 or more'
    end
  end

  def validate_sentences_length(name, value, min_length, max_length, min_sentences)
    validate_length name, value, min_length, max_length
    validate_sentences name, value, min_sentences
  end

  def validate_length(name, value, min_length, max_length)
    if value.length < min_length
      add_validation name + ' should be at least ' + min_length.to_s + ' characters'
    elsif value.length > max_length
      add_validation name + ' should be fewer than ' + (max_length + 1).to_s + ' characters'
    end
  end

  def validate_sentences(name, value, min_count)
    sentences = value.split('.')
    words = sentences.map { |sentence| sentence.split.size }.select { |words| words > 5 }
    if words.size < min_count
      add_validation name + ' should have at least ' + min_count.to_s + ' full ' + 'sentence'.pluralize(min_count)
    elsif not value.end_with?('.')
      add_validation name + ' should ' + (min_count > 1 ? 'end with' : 'be a') + ' complete sentence'
    end
  end

  def add_validation(message)
    if self.validations.nil?
      self.validations = message
    else
      self.validations += '|' + message
    end
  end

  # this method creates a fake estimation on submitted requests if they are more than 5 minutes old
  def estimate
    if self.submitted? && (Time.now - self.updated_at) > 5 * 60
      # re-initialize the estimates
      self.estimated_cost = nil
      self.estimated_duration = nil
      # only estimate projects with a budget of $200K!  because why bother!
      budget = self.budget_allocated
      if budget > 200_000
        # give them a 50/50
        if rand > 0.5
          # estimate the number of college grads needed during the time frame + 30%
          # to consume the budget * 2
          days = ((self.end_date - self.start_date) * 1.3).ceil
          budget_per_day = budget * 2 / days
          student_per_day = 200 * 8 # $200/hour * 8 hours
          students = (budget_per_day / student_per_day).ceil
          self.estimated_cost = students * student_per_day * days
          self.estimate_breakdown = number_with_delimiter(students) + ' resources needed at $200/hour for ' +
                                    number_with_delimiter(days) + ' days.'
          self.estimated_duration = (self.start_date + days * 7 / 5).strftime("%B %-m %Y")
        else
          self.estimate_breakdown = 'Jay has reviewed your request, and does not believe the requirements are ' +
              'feasible within the budget and time frames.  Please try submitting another request.'
        end
      else
        self.estimate_breakdown = 'Jay has reviewed your request, and the allocated budget is not sufficient to meet ' +
            'the requirements.  Please try submitting another request.'
      end
      self.status = :complete
      self.save
    end
  end
end
