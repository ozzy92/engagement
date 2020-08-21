module EngagementRequestsHelper

  # I'm presuming this module is for mix in functions
  # I'm going to use it for my validations, this is mixed into the model
  # The point of this function is to be as annoying as possible, and prevent success
  def validate
    # assume we are invalid, unless we manage to pass everything
    self.status = :validation

    if self.validate_required &&
          self.validate_contacts

        # success!  miraculous!
        self.status = :submitted
    end
  end

  # make sure all user entered fields are filled with something
  def validate_required
    [
        :project_name,
        :status,
        :requester,
        :subject_expert,
        :sponsor,
        :vision,
        :goal,
        :description,
        :scope,
        :advice_required,
        :program,
        :train,
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
      if self.attributes[field].nil?
        # intentionally vague!
        self.validations = 'All fields are required'
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
    if Set(contacts).length != contacts.length
      self.validations = 'All contacts must be unique'
      return false
    end

    # sponsor should be higher than expert, and expert higher than requestor, just because
    if self.sponsor.title.rank <= self.subject_expert.title.rank
      self.validations = 'Sponsor should be a higher rank than the Subject Expert'
      return false
    end
    if self.requester.title.rank >= self.subject_expert.title.rank
      self.validations = 'Requester should be lower rank than Subject Expert'
    end

    # contacts are co-located!
    if Set(contacts.map { |contact| contact.office.mail_code }).length != contacts.length
      self.validations = 'All contacts should be co-located'
    end

    true
  end

end
