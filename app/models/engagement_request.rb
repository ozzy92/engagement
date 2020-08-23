class EngagementRequest < ApplicationRecord
  include EngagementRequestsHelper

  enum engagement_type: [ :finger_estimate, :detailed_estimate, :scheduling, :rescue ]
  enum status: [ :validation, :submitted, :estimated, :in_progress, :complete ]
  enum funding_method: [ :client, :initiative, :operations ]
  enum funding_status: [ :requested, :pending_approval, :approved, :budget ]
  enum priority: [ :high_priority, :medium_priority, :low_priority ]
  enum risk_rating: [ :high_risk, :medium_risk, :low_risk ]

  belongs_to :user, optional: true, class_name: 'Employee', foreign_key: 'user_id'
  belongs_to :requester, optional: true, class_name: 'Employee', foreign_key: 'requester_id'
  belongs_to :subject_expert, optional: true, class_name: 'Employee', foreign_key: 'subject_expert_id'
  belongs_to :sponsor, optional: true, class_name: 'Employee', foreign_key: 'sponsor_id'
  belongs_to :program, optional: true
  belongs_to :train, optional: true
  has_many :impacted_projects
  has_many :projects, through: :impacted_projects

  # I've seen things saying this should be in internationalization....
  # I can't be bothered to figure that out right now, this is just code! :)

  ENGAGEMENT_TYPES = {
      "finger_estimate" => 'Finger in the Air Estimate',
      "detailed_estimate" => 'Detailed Project Estimate',
      "scheduling" => 'Resource Scheduling',
      "rescue" => 'Problem Rescue'
  }

  STATUSES = {
      "validation" => 'Validation',
      "submitted" => 'Submitted',
      "estimated" => 'Estimated',
      "in_progress" => 'In Progress',
      "complete" => 'Complete'
  }

  FUNDING_METHODS = {
      "client" => 'Client Project',
      "initiative" => 'Internal Initiative',
      "operations" => 'Operations Budget',
  }

  FUNDING_STATUSES = {
      "requested" => 'Request Initiated',
      "pending_approval" => 'Pending Approval',
      "approved" => 'Fully Approved',
      "budget" => 'Budget Appropriated',
  }

  PRIORITIES = {
      "high_priority" => 'High',
      "medium_priority" => 'Medium',
      "low_priority" => 'Low',
  }

  RISK_RATINGS = {
      "high_risk" => 'High',
      "medium_risk" => 'Medium',
      "low_risk" => 'Low',
  }

end
