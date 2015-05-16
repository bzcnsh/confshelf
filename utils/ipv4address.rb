require "ipaddress"

#commonly used methods: netmask, aclmask, prefix, address
class Ipv4address < IPAddress::IPv4
  def aclmask
    ipnetmask = IPAddress(self.netmask)
    IPAddress::IPv4::parse_u32(~ipnetmask.u32).address
  end
end
