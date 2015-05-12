require 'yaml'
require_relative 'component/device'
require_relative 'component/interface'
require_relative 'component/vlan'
require_relative 'component/ipvfoursubnet'
require_relative 'component/etherchannel'
require_relative 'component/prefixlist'
require_relative 'component/routerospf'
require_relative 'component/aaa'
require_relative 'templateManager'
deviceDefinition = YAML.load_file('model/device.yml')
Device.classProperties=deviceDefinition

interfaceDefinition = YAML.load_file('model/interface.yml')
Interface.classProperties=interfaceDefinition

templateTree = YAML.load_file('data/template.yml')
tm = TemplateManager.new(templateTree)

devices = []
deviceData = YAML.load_file('data/device.yml')
deviceData.each { |d|
  dev = Device.new()
  dev.setProperties(d)
  t = tm.lookupTemplate(dev, "device")
  dev.template=t
  devices  << dev
}

componentDB = {
  "interface" =>  {"list"=>[], "componentClass"=>Interface},
  "vlan" =>  {"list"=>[], "componentClass"=>Vlan},
  "ipvfoursubnet" =>  {"list"=>[], "componentClass"=>Ipvfoursubnet},
  "etherchannel" =>  {"list"=>[], "componentClass"=>Etherchannel},
  "prefixlist" =>  {"list"=>[], "componentClass"=>Prefixlist},
  "routerospf" =>  {"list"=>[], "componentClass"=>Routerospf},
  "aaa" =>  {"list"=>[], "componentClass"=>Aaa},
}

componentDB.each {|k, v|
  data = YAML.load_file("data/#{k}.yml")
  data.each { |d|
    component = v["componentClass"].new()
    #puts d.inspect
    component.setProperties(d)
    v["list"] << component
    devices.each { |dev|
      if component.isAssociatedWith(dev)
        dev.getAssociateComponents.push(component)
        t = tm.lookupTemplate(dev, component.class.name)
        component.template=t
      end
    }
  }
}

devices[0].getConfig.each {|c| puts c}

=begin
devices.each { |d|
  configs = d.getConfig()
  configs.each {|c| puts c}
  puts "---------------"
}

begin
  puts tm.lookupTemplate2("IOS", "12.6", "vlan")
rescue Exception=>e
  puts e.message
  puts e.backtrace.inspect
end
=end

#read class definition
#add property accessor methods to class definition
#read instance inventory
#create instances
#instantiate devices
#resolve device templates based on OS, OSVersion

