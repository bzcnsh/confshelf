require "component/baseComponent"
#sample prefixes
# - {network: 192.171.2.0, seq: 10, mask_length: 24, mask_range: "le 32"}

class Prefixlist < BaseComponent
  attr_accessor :description, :prefixes
  def isAssociatedWith(componentName, componentType)
    #always true for testing
    return true
  end
end

