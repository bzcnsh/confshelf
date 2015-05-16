require "component/baseComponent"
=begin
local_users: List of local users
 - {name: username, password: user password, encryption: password encryption scheme, privilege: numeric value}
local_usergroups: List of local user groups, tells what users should be created on what devices
  - {name: groupname, users: [username1, username2], devices: [device1, device2, device3]}
aaa_servers: list of aaa servers
 - {protocol: radius/ldap etc, host: aaa server ip, auth-port: port number, acct-port: port number, key: key to communicate with server}
aaa_server_groups: list of aaa server groups
  - name: server group name
    protocol: radius/ldap etc
    protocol_parameters: {deadtimer: in seconds}
    servers:
    - {host: server ip, auth-port: port number, acct-port: port number}
aaa_client_devices: list of aaa client devices
  - {device: device hostname, aaa_protocols: [{protocol: radius/ldap etc, source_interface: source interface client use to communicate with aaa server}]}
aaa_client_devices_authentication: list of devices and how their resources are being protected 
  - {device: hostname, protected: login/console etc, authorities: [{type: local_users/aaa_server/aaa_server_group, name: authority name}]}
=end
class Aaa < BaseComponent
  attr_accessor :local_users, :local_usergroups, :aaa_servers, :aaa_server_groups, :aaa_client_device, :aaa_client_device_authentication
  def getConfig(device)
    #optimization: can use hashdiff gem
    @context_local_usergroups = @local_usergroups.select{|x| x['devices'].include?(device.name)}
    localusers = []
    @context_local_usergroups.each {|x| localusers.push(*x["users"])}
    @context_local_users = @local_users.select{|x| localusers.include?(x["name"])}
    @context_aaa_client_devices = @aaa_client_devices.select{|x| x["device_name"]==device.name}
    @context_aaa_client_devices_authentication = @aaa_client_devices_authentication.select{|x| x["device_name"]==device.name}
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
