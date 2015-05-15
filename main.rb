libdir = File.expand_path("..", __FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'yaml'
require 'component/device'
require 'component/interface'
require 'component/vlan'
require 'component/ipvfoursubnet'
require 'component/etherchannel'
require 'component/prefixlist'
require 'component/routerospf'
require 'component/aaa'
require 'templateManager'

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


