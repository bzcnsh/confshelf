require 'erb'
#base class for all components
class BaseComponent
  # hold names of all instance variables
  @@classProperties = {}
  # dynamically create instance variables and their accessors
  # @param names (hash) a hash whose keys are names of instance variables
  def self.classProperties=(names)
    @@classProperties = names
    @@classProperties.each { |name, value| 
      define_property name
    }
  end
  # dynamically create instance variable accessors
  def self.define_property(name)
    define_method(name) do
      instance_variable_get("@#{name}")
    end
    define_method("#{name}=") do |new_value|
      instance_variable_set("@#{name}", new_value)
    end
  end
  def template=(template)
    @template = template
  end
  def getConfig
    return @template.result(get_binding)
  end
  #
  def getConfig(device)
    return @template.result(get_binding)
  end
  def setProperties(properties)
    properties.each { |name, value| 
      instance_variable_set("@#{name}", value)
    }
  end
  def get_binding
    binding
  end
  # check if self is associated with a device
  #
  # == Parameters:
  # device::
  #   the device to check association with
  #
  # == Returns:
  # true if there is an association, false if not.
  #
  def isAssociatedWith(device)
    if instance_variable_defined?("@device") and device.name==@device
      return true
    else
      return false
    end
  end
end