# frozen_string_literal: true

module RuboCop
  module Cop
    module CableReady
      class UnusedCableReadyCall < Base
        MSG = "unused `cable_ready` call"

        def on_send(definition)
          return if definition.method_name != :cable_ready

          call = definition.ancestors.first

          return if call.instance_of? RuboCop::AST::SendNode

          add_offense(definition)
        end
      end
    end
  end
end
