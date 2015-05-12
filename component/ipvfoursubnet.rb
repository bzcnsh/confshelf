require_relative "baseComponent"
class Ipvfoursubnet < BaseComponent
  def isAssociatedWith(device)
    if @interfaces.select{|i| i["device"] == device.name}.length>0
      return true
    else
      return false
    end
  end
  def getConfig(device)
    @device = device
    return @template.result(get_binding)
  end
end