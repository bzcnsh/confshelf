require_relative "baseComponent"
class Etherchannel < BaseComponent
  def isAssociatedWith(device)
    if @member_interfaces.select{|i| i["device"] == device.name}.length>0
      return true
    else
      return false
    end
  end
  def getConfig(device)
    @device_interfaces = @member_interfaces.select{|x| x['device']==device.name}
    return @template.result(get_binding)
  end
end