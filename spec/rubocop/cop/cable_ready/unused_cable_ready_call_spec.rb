# frozen_string_literal: true

RSpec.describe RuboCop::Cop::CableReady::UnusedCableReadyCall, :config do
  it "registers an offense for an unused cable_ready call" do
    expect_offense(<<~RUBY)
      class Foo
        include CableReady::Broadcaster
 
        def bar
          cable_ready
          ^^^^^^^^^^^ unused `cable_ready` call
        end
      end
    RUBY
  end

  it "doesn't register an offense if cable_ready.broadcast is called" do
    expect_no_offenses(<<~RUBY)
      class Foo
        include CableReady::Broadcaster

        def bar
          cable_ready["MyChannel"].morph({
            selector: "#foo",
            html: "<div></div>"
          })
          cable_ready.broadcast
        end
      end
    RUBY
  end
end
