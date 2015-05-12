require_relative "baseComponent"
class Prefixlist < BaseComponent
  #a prefix won't know if it's associated with a device, an instance that use this prefix will know
  def isAssociatedWith(device)
    #always true for testing
    return true
  end
end