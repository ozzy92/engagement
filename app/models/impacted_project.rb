class ImpactedProject < ApplicationRecord
  belongs_to :project
  belongs_to :engagement_request
end
