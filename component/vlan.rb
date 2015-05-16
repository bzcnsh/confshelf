require "component/baseComponent"

#sample list of interfaces
# - {device_name: hostname, name: eth0/6, mode: access/trunk/voice/routed, features: {portfast: true}}
class Vlan < BaseComponent
  attr_accessor :vlanid, :interfaces
  def getConfig(device)
    @device_interfaces = @interfaces.select{|x| x['device_name']==device.name}
    return @template.result(get_binding)
  end
end

