require "component/baseComponent"

=begin
area: area id
features: features of this area, i.e. nssa, stub, etc
networks: list of networks to be included in this area
devices:
  list of devices participating in this area
  - {device_name: device hostname, router_id: ospf router id, process_id: ospf process id}
interfaces:
  list of interfaces participating in this area
  - {device_name: device name, id: 'interface id, i.e, eth0/0', passive: true/false for passive interface, hello_interval: in seconds, cost: ospf cost of the interface, priority: int for DR priority}
=end

class Routerospf < BaseComponent
  attr_accessor :area, :features, :networks, :devices, :interfaces
  def getConfig(device)
    @device = device
    @context_device = @devices.select{|x| x['device_name']==device.name}[0]
    @context_interfaces = @interfaces.select{|x| x['device_name']==device.name}
    return @template.result(get_binding)
  end
end
