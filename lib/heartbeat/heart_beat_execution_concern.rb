# frozen_string_literal: true

require "active_support/concern"

module Heartbeat
  module HeartBeatExecutionConcern
    extend ActiveSupport::Concern

    STATUSES = %w[started completed failed retried].freeze

    included do
      belongs_to :heart_beat, foreign_key: :heartbeat_id, inverse_of: :heart_beat_executions

      validates :status, presence: true, inclusion: { in: STATUSES }
      validates :started_at, presence: true
      validates :attempt_number, presence: true, numericality: { greater_than: 0 }

      scope :recent, -> { order(started_at: :desc) }
      scope :failed, -> { where(status: "failed") }
      scope :completed, -> { where(status: "completed") }
    end
  end
end
