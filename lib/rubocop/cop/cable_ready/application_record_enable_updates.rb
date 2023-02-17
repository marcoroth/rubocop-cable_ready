# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      class ApplicationRecordEnableUpdates < Base
        MSG = "%<method_name>s should not be switched on globally"

        def_node_search :active_record_base_class?, <<~PATTERN
          (const (const nil? :ActiveRecord) :Base)
        PATTERN

        def_node_matcher :is_application_record?, <<~PATTERN
          (const nil? :ApplicationRecord)
        PATTERN

        def on_send(node)
          receiver_node, _method_name, *_arg_nodes = *node.parent.parent

          return unless %i[enable_updates enable_cable_ready_updates].include?(node.method_name)

          return unless is_application_record?(receiver_node)

          return unless node.ancestors.any? { |ancestor| active_record_base_class?(ancestor) }

          message = format(MSG, method_name: node.method_name)
          add_offense(node, message: message)
        end
      end
    end
  end
end
