require "spec_helper"
require  "templateManager"

describe "Ipv4address/" do
  before do
    @testip = Ipv4address.new("192.168.1.1/23")
  end
  
  it "192.168.1.1/23 prefix=23"  do
    expect(@testip.prefix.to_i).to eql(23)
  end
  it "192.168.1.1/23 netmask=255.255.254.0"  do
    expect(@testip.netmask).to eql("255.255.254.0")
  end
  it "192.168.1.1/23 aclmask=0.0.1.255"  do
    expect(@testip.aclmask).to eql("0.0.1.255")
  end
  it "192.168.1.1/23 change prefix to 24"  do
    @testip.prefix=24
    expect(@testip.prefix.to_i).to eql(24)
  end
  it "192.168.1.1/23 change netmask to 255.255.255.224.0"  do
    @testip.netmask="255.255.255.224"
    expect(@testip.prefix.to_i).to eql(27)
  end
end
