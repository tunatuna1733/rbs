require "test_helper"

class RBS::ParamConstTest < Test::Unit::TestCase
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

  def test_param_const_1
    assert_writer <<-SIG
class Foo
  def foo: (const bool) -> String
end
    SIG
  end

  def test_param_const_2
    assert_writer <<-SIG
class Foo
  def foo: (const Integer) -> String
end
    SIG
  end

  def test_param_const_3
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | String)) -> String
end
    SIG
  end

  def test_param_const_4
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | bool)) -> String
end
    SIG
  end

  def test_param_const_5
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer & String)) -> String
end
    SIG
  end

  def test_param_const_6
    assert_writer <<-SIG
class Foo
  def foo: (const bool, Integer) -> String
end
    SIG
  end

  def test_param_const_7
    assert_writer <<-SIG
class Foo
  def foo: (bool, const Integer) -> String
end
    SIG
  end

  def test_param_const_8
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | String), bool) -> String
end
    SIG
  end

  def test_param_const_9
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | bool), const String) -> String
end
    SIG
  end

  def test_param_const_10
    assert_writer <<-SIG
class Foo
  def foo: (bool, const (Integer & String)) -> String
end
    SIG
  end

  def test_param_const_11
    assert_writer <<-SIG
class Foo
  def foo: (const bool, const String) -> String
end
    SIG
  end

  def test_param_const_12
    assert_writer <<-SIG
class Foo
  def foo: (const Integer, const Foo) -> String
end
    SIG
  end

  def test_param_const_13
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | String), const (Intger | bool)) -> String
end
    SIG
  end

  def test_param_const_14
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | bool), const (Integer | String)) -> String
end
    SIG
  end

  def test_param_const_15
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer & String), const Foo) -> String
end
    SIG
  end

  def test_param_const_16
    assert_writer <<-SIG
class Foo
  def foo: (const bool, Integer, const String) -> String
end
    SIG
  end

  def test_param_const_17
    assert_writer <<-SIG
class Foo
  def foo: (bool, const Integer, String) -> String
end
    SIG
  end

  def test_param_const_18
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | String), bool, const (Integer & Foo)) -> String
end
    SIG
  end

  def test_param_const_19
    assert_writer <<-SIG
class Foo
  def foo: (const (Integer | bool), const String, bool) -> String
end
    SIG
  end

  def test_param_const_20
    assert_writer <<-SIG
class Foo
  def foo: (bool, const (Integer & String), const (String | Foo)) -> String
end
    SIG
  end
end