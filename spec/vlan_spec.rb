require "spec_helper"
require "component/vlan"

describe "Vlan test/" do
  before do
    @vlans = []
    vlanData = YAML.load_file('test-data/vlan.yml')
    vlanData.each { |d|
      vlan = Vlan.new()
      vlan.properties=d
      @vlans  << vlan
    }
  end
  
  it "expect 1 vlan" do
    expect(@vlans.size).to eq(1)
  end
  it "vlan is associated with rt1" do
    expect(@vlans[0].isAssociatedWith("rt1", "device")).to be true
  end
  it "vlan is not associated with rt3" do
    expect(@vlans[0].isAssociatedWith("rt3", "device")).to be false
  end
end

