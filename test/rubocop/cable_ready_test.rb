# frozen_string_literal: true

require "test_helper"

module Rubocop
  class CableReadyTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Rubocop::CableReady::VERSION
    end
  end
end
