require "spec_helper"
require "component/vlan"

describe "Vlan test/" do
  before do
    @device_rt1 = double(:name => "rt1", :OS => "IOS", :OSVersion=>"12.6")
    @device_rt3 = double(:name => "rt3", :OS => "IOS", :OSVersion=>"12.6")
    vlanDefinition = YAML.load_file('model/vlan.yml')
    Vlan.classProperties=vlanDefinition
    @vlans = []
    vlanData = YAML.load_file('test-data/vlan.yml')
    vlanData.each { |d|
      vlan = Vlan.new()
      vlan.setProperties(d)
      @vlans  << vlan
    }
  end
  
  it "expect 1 vlan" do
    expect(@vlans.size).to eq(1)
  end
  it "vlan is associated with rt1" do
    expect(@vlans[0].isAssociatedWith(@device_rt1)).to be true
  end
  it "vlan is not associated with rt3" do
    expect(@vlans[0].isAssociatedWith(@device_rt3)).to be false
  end
end

