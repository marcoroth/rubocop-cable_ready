# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      class ApplicationRecordEnableUpdates < Base
        MSG = "enable_updates should not be switched on globally"

        def_node_search :active_record_base_class?, <<~PATTERN
          (const (const nil? :ActiveRecord) :Base)
        PATTERN

        def_node_matcher :is_application_record?, <<~PATTERN
          (const nil? :ApplicationRecord)
        PATTERN

        def on_send(node)
          receiver_node, _method_name, *_arg_nodes = *node.parent.parent

          return if node.method_name != :enable_updates

          return unless is_application_record?(receiver_node)

          return unless node.ancestors.any? { |ancestor| active_record_base_class?(ancestor) }

          add_offense(node)
        end
      end
    end
  end
end
