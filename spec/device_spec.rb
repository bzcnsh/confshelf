require 'yaml'
require_relative "../component/device"

describe "Device test/" do
  before do
    deviceDefinition = YAML.load_file('model/device.yml')
    Device.classProperties=deviceDefinition

    @devices = []
    deviceData = YAML.load_file('test-data/device.yml')
    deviceData.each { |d|
      dev = Device.new()
      dev.setProperties(d)
      @devices  << dev
    }
  end
  
  it "expect 2 devices" do
    expect(@devices.size).to eq(2)
  end
  it "the 2nd device name is rt2" do
    expect(@devices[1].name).to eq("rt2")
  end
end
