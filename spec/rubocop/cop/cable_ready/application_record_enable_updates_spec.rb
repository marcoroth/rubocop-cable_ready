# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::CableReady::ApplicationRecordEnableUpdates, :config do
  it "registers an offense for the global ApplicationRecord model calling the enable_cable_ready_updates class method" do
    expect_offense(<<~RUBY)
      class ApplicationRecord < ActiveRecord::Base
        include CableReady::Updatable

        enable_cable_ready_updates on: :update
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ enable_cable_ready_updates should not be switched on globally
      end
    RUBY
  end

  it "registers an offense for the global ApplicationRecord model calling the enable_updates class method" do
    expect_offense(<<~RUBY)
      class ApplicationRecord < ActiveRecord::Base
        include CableReady::Updatable

        enable_updates on: :update
        ^^^^^^^^^^^^^^^^^^^^^^^^^^ enable_updates should not be switched on globally
      end
    RUBY
  end

  it "doesn't register an offense for any other model calling the enable_cable_ready_updates class method" do
    expect_no_offenses(<<~RUBY)
      class Foo < ActiveRecord::Base
        include CableReady::Updatable

        enable_cable_ready_updates on: :update
      end
    RUBY
  end

  it "doesn't register an offense for any other model calling the enable_updates class method" do
    expect_no_offenses(<<~RUBY)
      class Foo < ActiveRecord::Base
        include CableReady::Updatable

        enable_updates on: :update
      end
    RUBY
  end
end
