require "spec_helper"
require  "templateManager"

describe "TemplateManager test/" do
  before do
    @device_rt110 = double(:name => "rt110", :OS => "IOS", :OSVersion=>"11.00")
    @device_rt120 = double(:name => "rt120", :OS => "IOS", :OSVersion=>"12.00")
    @device_rt121 = double(:name => "rt121", :OS => "IOS", :OSVersion=>"12.01")
    @device_rt130 = double(:name => "rt130", :OS => "IOS", :OSVersion=>"13.00")
    @device_rt131 = double(:name => "rt131", :OS => "IOS", :OSVersion=>"13.01")
    @device_rt133 = double(:name => "rt133", :OS => "IOS", :OSVersion=>"13.03")
    @device_rt138 = double(:name => "rt138", :OS => "IOS", :OSVersion=>"13.08")
    @device_rt139 = double(:name => "rt139", :OS => "IOS", :OSVersion=>"13.09")
    @device_rt140 = double(:name => "rt140", :OS => "IOS", :OSVersion=>"14.00")
    templateTree = YAML.load_file('test-data/template.yml')
    @tm = TemplateManager.new(templateTree)
  end
  it "formatVersionConstraint >12.3"  do
    expect(@tm.formatVersionConstraint(">12.3")).to eql(">\"12.3\"")
  end
  it "formatVersionConstraint =12.3"  do
    expect(@tm.formatVersionConstraint("=12.3")).to eql("==\"12.3\"")
  end
  it "formatVersionConstraint <=12.3"  do
    expect(@tm.formatVersionConstraint("<=12.3")).to eql("<=\"12.3\"")
  end

  it "matchAVersionContraint(12.0<=12.0)" do
    expect(@tm.matchAVersionContraint("12.0", "<=\"12.0\"")).to be true
  end
  it "matchAVersionContraint(12.0<12.1)" do
    expect(@tm.matchAVersionContraint("12.0", "<\"12.1\"")).to be true
  end
  it "matchAVersionContraint(12.0>12.0)" do
    expect(@tm.matchAVersionContraint("12.0", ">\"12.0\"")).to be false
  end
  it "device template for device IOS 11.0 does not exist" do
    expect(@tm.lookupTemplateFilename(@device_rt110, "device")).to be_nil
  end

  it "device template for device IOS 12.0 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt120, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 12.0 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt120, "vlan")).to eq("vlan_ios_12.erb")
  end

  it "device template for device IOS 12.1 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt121, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 12.1 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt121, "vlan")).to eq("vlan_ios_12.erb")
  end

  it "device template for device IOS 13.0 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt130, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 13.0 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt130, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "hsrp template for device IOS 13.0 is hsrp_ios_130.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt130, "hsrp")).to eq("hsrp_ios_130.erb")
  end

  it "aabb template for aabb IOS 13.1 does not exist" do
    expect(@tm.lookupTemplateFilename(@device_rt131, "aabb")).to be_nil
  end
  it "device template for device IOS 13.1 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt131, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 13.1 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt131, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "hsrp template for device IOS 13.1 is hsrp_ios_130.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt131, "hsrp")).to eq("hsrp_ios_130.erb")
  end

  it "device template for device IOS 13.3 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt133, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 13.3 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt133, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "grrp template for device IOS 13.3 is grrp_ios_130.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt133, "grrp")).to eq("grrp_ios_13.erb")
  end
  
  it "device template for device IOS 13.8 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt138, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 13.8 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt138, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "grrp template for device IOS 13.8 is grrp_ios_130.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt138, "grrp")).to eq("grrp_ios_13.erb")
  end

  it "device template for device IOS 13.9 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt139, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 13.9 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt139, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "grrp template for device IOS 13.9 is grrp_ios_13.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt139, "grrp")).to eq("grrp_ios_13.erb")
  end
  it "hsrp template for device IOS 13.9 is hsrp_ios_13.8.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt139, "hsrp")).to eq("hsrp_ios_13.8.erb")
  end

  it "device template for device IOS 14 is null" do
    expect(@tm.lookupTemplateFilename(@device_rt140, "device")).to be_nil
  end
  it "hsrp template for device IOS 14 is hsrp_ios_14.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt140, "hsrp")).to eq("hsrp_ios_14.erb")
  end
end
