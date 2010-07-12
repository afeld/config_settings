require 'test_helper'

class ConfigSettingTest < ActiveSupport::TestCase
  test "invalid with empty key" do
    setting = ConfigSetting.new
    assert !setting.valid?
    assert setting.errors.invalid?(:key)
  end
  
  test "setting value sets value_class" do
    value = 123
    
    setting = ConfigSetting.new(:value => value)
    assert_equal(setting.value_class, value.class.to_s)
  end
  
  test "updating value updates value_class" do
    new_val = "abc"
    
    setting = ConfigSetting.new(:value => 10.0)
    setting.value = new_val
    assert_equal(setting.value_class, new_val.class.to_s)
  end
  
  test "keys must be unique" do
    key = "duplicate"
    setting1 = ConfigSetting.create(:key => key, :value => 123)
    setting2 = ConfigSetting.new(:key => key, :value => 456)
    assert !setting2.valid?
    assert setting2.errors.invalid?(:key)
  end
  
  test "string value properly returned" do
    assert_value_properly_returned("abc")
  end
  
  test "integer value properly returned" do
    assert_value_properly_returned(123)
  end
  
  test "float value properly returned" do
    assert_value_properly_returned(123.4)
  end
  
  test "nil value properly returned" do
    assert_value_properly_returned(nil)
  end
  
  test "true value properly returned" do
    assert_value_properly_returned(true)
  end
  
  test "false value properly returned" do
    assert_value_properly_returned(false)
  end
  
  
  def assert_value_properly_returned(value)
    setting = ConfigSetting.create(:key => value.class.to_s + " setting", :value => value)
    unless setting.nil?
      setting = ConfigSetting.find(setting.id)
      assert_equal(setting.value, value)
      assert_equal(setting.value.class, value.class)
    end
  end
end
