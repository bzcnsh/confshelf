require_relative "baseComponent"
class Routerospf < BaseComponent
  def isAssociatedWith(device)
    if @devices.select{|i| i["device"] == device.name}.length>0
      return true
    else
      return false
    end
  end
  def getConfig(device)
    @device = device
    @context_device = @devices.select{|x| x['device']==device.name}[0]
    @context_interfaces = @interfaces.select{|x| x['device']==device.name}
    return @template.result(get_binding)
  end
end
