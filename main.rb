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

#read class definition
#add property accessor methods to class definition
#read instance inventory
#create instances
#instantiate devices
#resolve device templates based on OS, OSVersion
#resolve component templates based on device and component type

templateTree = YAML.load_file('data/template.yml')
tm = TemplateManager.new(templateTree)

componentDB = {
  "device" =>  {"list"=>[], "componentClass"=>Device},
  "interface" =>  {"list"=>[], "componentClass"=>Interface},
  "vlan" =>  {"list"=>[], "componentClass"=>Vlan},
  "ipvfoursubnet" =>  {"list"=>[], "componentClass"=>Ipvfoursubnet},
  "etherchannel" =>  {"list"=>[], "componentClass"=>Etherchannel},
  "prefixlist" =>  {"list"=>[], "componentClass"=>Prefixlist},
  "routerospf" =>  {"list"=>[], "componentClass"=>Routerospf},
  "aaa" =>  {"list"=>[], "componentClass"=>Aaa},
}

componentDB.each {|k, v|
  componentDefinition = YAML.load_file("model/#{k}.yml")
  v["componentClass"].classProperties=componentDefinition
  data = YAML.load_file("data/#{k}.yml")
  data.each { |d|
    component = v["componentClass"].new()
    #puts d.inspect
    component.setProperties(d)
    v["list"] << component
    if k == "device"
      t = tm.lookupTemplate(component, "device")
      component.template=t
    else
      @devices.each { |dev|
        if component.isAssociatedWith(dev)
          dev.getAssociateComponents.push(component)
          t = tm.lookupTemplate(dev, component.class.name)
          component.template=t
        end
      }
    end
  }
  if k == "device"
    @devices = v["list"]
  end
}

@devices[0].getConfig.each {|c| puts c}


