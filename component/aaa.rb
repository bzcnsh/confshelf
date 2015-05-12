require_relative "baseComponent"
class Aaa < BaseComponent
  def isAssociatedWith(device)
    return true
  end
  def getConfig(device)
    #optimization: can use hashdiff gem
    @context_local_usergroups = @local_usergroups.select{|x| x['devices'].include?(device.name)}
    localusers = []
    @context_local_usergroups.each {|x| localusers.push(*x["users"])}
    @context_local_users = @local_users.select{|x| localusers.include?(x["name"])}
    @context_aaa_client_devices = @aaa_client_devices.select{|x| x["device"]==device.name}
    @context_aaa_client_devices_authentication = @aaa_client_devices_authentication.select{|x| x["device"]==device.name}
    aaaservergroup=[]
    @context_aaa_client_devices_authentication.each {|a| a["authorities"].select{|x| x["type"]=="aaa_server_group"}.each {|y| aaaservergroup.push(y["name"])}}
    @context_aaa_server_groups = @aaa_server_groups.select{|x| aaaservergroup.include?(x["name"])}
    aaaservers=[]
    @context_aaa_server_groups.each {|x| aaaservers.push(*x["servers"])}
    @context_aaa_servers = []
    @aaa_servers.each {|x|
      @context_aaa_servers.push(*x)
    }
    return @template.result(get_binding)
  end
end
