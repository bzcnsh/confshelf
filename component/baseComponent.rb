require 'erb'
require 'utils/misc'
#base class for all components
class BaseComponent
  include Misc
  attr_accessor :template, :name, :description, :client_components, :server_components
  # dynamically create instance variables and their accessors
  # @param names (hash) a hash whose keys are names of instance variables
  def initialize
    @associatedComponents=[]
    @client_components=[]
    @server_components=[]
  end
  def getConfig
    return @template.result(get_binding)
  end
  #
  def getConfig(device)
    return @template.result(get_binding)
  end
  def properties=(properties)
    @properties = properties
    properties.each { |name, value| 
      instance_variable_set("@#{name}", value)
    }
  end
  def get_binding
    binding
  end
  def matchComponent(value, key=nil)
    if value.to_s.casecmp(@componentBeingChecked["name"].to_s)==0
      @associatedComponents<<value unless @associatedComponents.include?(value)
    end
  end
  # check if self is associated with a component
  #
  # == Parameters:
  # componentName::
  #   name of the component
  # componentType::
  #   type of the component
  #
  # == Returns:
  # true if there is an association, false if not.
  #
  def isAssociatedWith(componentName, componentType=nil)
    @componentBeingChecked = {"name"=>componentName.to_s, "type"=>componentType}
    traverseStructure(@properties, nil, self.method(:matchComponent))
    return @associatedComponents.include?(componentName)
  end
end