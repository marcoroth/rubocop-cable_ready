# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::CableReady::BroadcasterControllerAction, :config do
  it "registers an offense for a controller mixing in Broadcaster" do
    expect_offense(<<~RUBY)
      class FoosController < ActionController::Base
        include CableReady::Broadcaster
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ CableReady::Broadcaster should not be used in a Rails controller action
      end
    RUBY
  end

  it "registers an offense for an indirect subclass of ActionController::Base" do
    expect_offense(<<~RUBY)
      class ApplicationController < ActionController::Base
      end

      class BarsController < ApplicationController
        include CableReady::Broadcaster
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ CableReady::Broadcaster should not be used in a Rails controller action
      end
    RUBY
  end

  it "doesn't register an offense for a model mixing in Broadcaster" do
    expect_no_offenses(<<~RUBY)
      class Foo < ActiveRecord::Base
        include CableReady::Broadcaster
      end
    RUBY
  end

  it "doesn't register an offense for a job mixing in Broadcaster" do
    expect_no_offenses(<<~RUBY)
      class Foo < ActiveJob::Base
        include CableReady::Broadcaster
      end
    RUBY
  end
end
