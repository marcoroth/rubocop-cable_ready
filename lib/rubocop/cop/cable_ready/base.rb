# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      # @abstract parent class to CableReady cops
      class Base < ::RuboCop::Cop::Base
        exclude_from_registry

        # Invoke the original inherited hook so our cops are recognized
        def self.inherited(subclass) # rubocop:disable Lint/MissingSuper
          RuboCop::Cop::Base.inherited(subclass)
        end
      end
    end
  end
end
