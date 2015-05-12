require 'yaml'
require_relative "../templateManager"

describe "TemplateManager test/" do
  before do
    @device_rt1 = double(:name => "rt1", :OS => "IOS", :OSVersion=>"12.0")
    @device_rt3 = double(:name => "rt3", :OS => "IOS", :OSVersion=>"12.6")
    templateTree = YAML.load_file('data/template.yml')
    @tm = TemplateManager.new(templateTree)
  end
  
  it "device template for device IOS 12.0 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt1, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 12.0 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt1, "vlan")).to eq("vlan_ios_12.erb")
  end
  it "device template for device IOS 12.6 is device_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt3, "device")).to eq("device_ios_12.erb")
  end
  it "vlan template for device IOS 12.6 is vlan_ios_12.erb" do
    expect(@tm.lookupTemplateFilename(@device_rt3, "vlan")).to eq("vlan_ios_12.erb")
  end
end
