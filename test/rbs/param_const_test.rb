require "test_helper"

class RBS::WriterTest < Test::Unit::TestCase
  include TestHelper

  Parser = RBS::Parser
  Writer = RBS::Writer

  def format(sig, preserve: false)
    Parser.parse_signature(sig).then do |_, dirs, decls|
      writer = Writer.new(out: StringIO.new).preserve!(preserve: preserve)
      writer.write(dirs + decls)

      writer.out.string
    end
  end

  def assert_writer(sig, preserve: false)
    assert_equal sig, format(sig, preserve: preserve)
  end

  def test_param_const
    assert_writer <<-SIG
class Foo
  def foo: (const bool) -> String
end
    SIG
  end
end