require "component/baseComponent"

#sample:
#- {vendor: cisco, model: "2610", OS: IOS, OSVersion: "12.6", name: rt1}
class Device < BaseComponent
  attr_accessor :vendor, :model, :OS, :OSVersion
  def initialize()
    @AssociatedComponents=[]
  end
  def getAssociateComponents()
    return @AssociatedComponents
  end
  def getConfig
    configs=[]
    configs.push(@template.result(get_binding))
    @AssociatedComponents.each {|c|
      configs.push(c.getConfig(self))
    }
    return configs
  end
end
