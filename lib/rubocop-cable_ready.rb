# frozen_string_literal: true

require "pathname"
require "yaml"

require "rubocop"

require_relative "rubocop/cable_ready/version"
require_relative "rubocop/cable_ready/inject"

RuboCop::CableReady::Inject.defaults!

require_relative "rubocop/cop/cable_ready_cops"
