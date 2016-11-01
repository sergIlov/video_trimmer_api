# Mongoid
module Mongoid
  # Provides ability to use workflow with mongoid models
  module Workflow
    extend ActiveSupport::Concern

    included do
      after_initialize :assign_default_state
    end

    private

    def load_workflow_state
      send(self.class.workflow_column)
    end

    def persist_workflow_state(new_value)
      update_attribute(self.class.workflow_column, new_value)
    end

    def assign_default_state
      send("#{self.class.workflow_column}=", current_state.to_s) if load_workflow_state.blank?
    end
  end
end
