class TemplateManager
  def initialize(templateArray)
    @templateHash = {}
    @templateArray = templateArray
    templateArray.each { |t| 
      @templateHash[t['name']] = t
    }
  end
  def lookupTemplate(device, component)
    #match by device OS, OS version
    #check component template
    #if component template's not defined, lookup the template ancestor tree
    template = lookupTemplate2(device.OS, device.OSVersion, component.downcase)
    #caching for performance improvement
    return ERB.new File.new("template/#{template}").read, nil, "<>"
  end
  def lookupTemplate2(os, osversion, component)
    template = @templateArray.select{|x| x['OS']==os and x['OSVersion']==osversion}
    if template.length==0
      puts "no template for #{os}, #{osversion}"
      raise "no template for #{os}, #{osversion}"
    end
    if template.length>1
      puts "more than one template for #{os}, #{osversion}"
      raise "more than one template for #{os}, #{osversion}"
    end
    t = lookupTemplate3(template[0]["name"], component)
    if t.nil?
      puts "no template for #{os}, #{osversion}. #{component}"
      raise "no template for #{os}, #{osversion}. #{component}"
    end
    return t      
  end
  #look up the ancestor tree
  def lookupTemplate3(templateName, component)
    if @templateHash[templateName].has_key?("#{component}_template")
      return @templateHash[templateName]["#{component}_template"]
    else
      if @templateHash[templateName].has_key?("super_template")
        return lookupTemplate3(@templateHash[templateName]["super_template"], component)
      else
        return nil
      end
    end
  end
end