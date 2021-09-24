# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      class BroadcasterControllerAction < Base
        MSG = "CableReady::Broadcaster should not be used in a Rails controller action"

        def_node_search :action_controller_base_class?, <<~PATTERN
          (const (const nil? :ActionController) :Base)
        PATTERN

        def on_send(definition)
          return if definition.method_name != :include

          call = definition.ancestors.first

          return unless action_controller_base_class?(call)

          add_offense(definition)
        end
      end
    end
  end
end
