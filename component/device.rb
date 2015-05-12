require_relative "baseComponent"
class Device < BaseComponent
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