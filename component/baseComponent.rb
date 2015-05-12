require 'erb'
class BaseComponent
  @@classProperties = {}
  def self.classProperties=(names)
    @@classProperties = names
    @@classProperties.each { |name, value| 
      define_property name
    }
  end
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
  def isAssociatedWith(device)
    if instance_variable_defined?("@device") and device.name==@device
      return true
    else
      return false
    end
  end
end