class ImpactedProject < ApplicationRecord
  # I couldn't get a multi-select option working for many to many, so this is here but not used :(
  belongs_to :project
  belongs_to :engagement_request
end
