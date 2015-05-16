require "component/baseComponent"
#sample member_interfaces:
#{device: rt1, id: eth0/0}
class Etherchannel < BaseComponent
  attr_accessor :channel_id, :mode, :member_interfaces
  def getConfig(device)
    @device_interfaces = @member_interfaces.select{|x| x['device_name']==device.name}
    return @template.result(get_binding)
  end
end
