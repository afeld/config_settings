class ConfigSetting < ActiveRecord::Base
  attr_protected :value_class, :value_string
  validates_presence_of :key
  validates_uniqueness_of :key
  validate :value_class_attribute_matches_value
  #validates_inclusion_of :value_class, :in => %w( String Fixnum Float NilClass TrueClass FalseClass ) 
  
  # the type-cast value is stored in this instance variable 
  # for very minor performance gain
  @return_val = nil
  
  def value_class_attribute_matches_value
    unless self.value_class.nil? or self.value.class.to_s != self.value_class
      errors.add_to_base("the class of the Value must match the value_class") 
    end
  end
  
  def value=(obj)
    self.value_class = obj.class.to_s
    write_attribute(:value_str, obj)
    @return_val = obj
  end
  
  def value
    if @return_val.nil?
      value_str = self.value_str
      case self.value_class
      when "String"
        @return_val = value_str #.to_s
      when "Fixnum"
        @return_val = value_str.to_i
      when "Float"
        @return_val = value_str.to_f
      when "NilClass"
        @return_val = nil
      when "TrueClass"
        @return_val = true
      when "FalseClass"
        @return_val = false
      end
    end
    
    @return_val
  end
end
