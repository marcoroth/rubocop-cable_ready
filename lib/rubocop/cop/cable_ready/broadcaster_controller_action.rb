# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      class BroadcasterControllerAction < Base
        MSG = "CableReady::Broadcaster should not be used in a Rails controller action"

        def_node_search :action_controller_base_class?, <<~PATTERN
          (const (const nil? :ActionController) :Base)
        PATTERN

        def on_send(node)
          return if node.method_name != :include

          return unless node.ancestors.any? { |ancestor| action_controller_base_class?(ancestor) }

          add_offense(node)
        end
      end
    end
  end
end
