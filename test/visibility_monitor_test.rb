require "test_helper"

class VisibilityMonitorTest < Minitest::Test
  def test_version
    refute_nil ::VisibilityMonitor::VERSION
  end

  VISIBILITIES = [:private, :protected, :public]

  def test_scoped_visibility
    klass = Class.new do
      extend VisibilityMonitor
      private
      def private_method; end
      protected
      def protected_method; end
      public
      def public_method; end
    end
    assert_equal :private, method_visibility(klass, :private_method)
    assert_equal :protected, method_visibility(klass, :protected_method)
    assert_equal :public, method_visibility(klass, :public_method)
  end

  def test_set_visibility
    klass = Class.new do
      extend VisibilityMonitor
      class << self
        attr_reader :visibility_set_calls
        def visibility_set(name, visibility)
          @visibility_set_calls << [name, visibility]
        end
      end
      @visibility_set_calls = []

      private def private_method; end
      protected def protected_method; end
      private
      public def public_method; end
    end

    expected_hook_calls = VISIBILITIES.map do |visibility|
      method_name = :"#{visibility}_method"
      assert_equal visibility, method_visibility(klass, method_name)
      [method_name, visibility]
    end
    assert_equal expected_hook_calls, klass.visibility_set_calls
  end

  private

  def method_visibility(klass, method_name)
    return :private if klass.private_method_defined?(method_name)
    return :protected if klass.protected_method_defined?(method_name)
    return :public if klass.public_method_defined?(method_name)
    raise NoMethodError
  end
end
