require "component/baseComponent"

=begin
a subnet is consisted of a subnet, a mask, and a list of interfaces on the subnet
interface sample:
- {device_name: rt1, name: eth0/0, address: 192.168.1.1}
=end
class Ipvfoursubnet < BaseComponent
  attr_accessor :subnet, :masklength, :interfaces
  def getConfig(device)
    @device = device
    return @template.result(get_binding)
  end
end