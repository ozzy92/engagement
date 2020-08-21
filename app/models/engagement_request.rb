class EngagementRequest < ApplicationRecord
  include EngagementRequestsHelper

  enum engagement_type: [ :finger_estimate, :detailed_estimate, :scheduling, :rescue ]
  enum status: [ :validation, :submitted, :estimated, :in_progress, :complete ]

  belongs_to :user, optional: true, class_name: 'Employee', foreign_key: 'user_id'
  belongs_to :requester, optional: true, class_name: 'Employee', foreign_key: 'requester_id'
  belongs_to :subject_expert, optional: true, class_name: 'Employee', foreign_key: 'subject_expert_id'
  belongs_to :sponsor, optional: true, class_name: 'Employee', foreign_key: 'sponsor_id'
  belongs_to :program, optional: true
  belongs_to :train, optional: true
  has_many :impacted_projects
  has_many :projects, through: :impacted_projects
end
