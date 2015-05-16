require "component/baseComponent"
#sample:
#{device_name: rt1, name: eth0/1, speed: 1000000, duplex: full, type: 1000BaseT}
class Interface < BaseComponent
  attr_accessor :device_name, :name, :speed, :duplex, :type
end
