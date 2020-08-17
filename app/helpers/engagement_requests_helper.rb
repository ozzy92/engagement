module EngagementRequestsHelper

  # I'm presuming this module is for mix in functions
  # I'm going to use it for my validations
  # The point of this function is to be as annoying as possible, and prevent success
  def validate
    # assume we are invalid
    self.status = :validation

    self.validations = 'This is just a test.'
  end

end
