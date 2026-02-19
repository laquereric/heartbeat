# frozen_string_literal: true

require_relative "heartbeat/version"
require_relative "heartbeat/heart_beat_concern"
require_relative "heartbeat/heart_beat_execution_concern"
require_relative "heartbeat/migration_helpers"

module Heartbeat
  class Error < StandardError; end
end
