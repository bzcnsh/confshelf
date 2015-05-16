#manages template, look up for template, given device and component
class TemplateManager
  def initialize(templateArray)
    @templateHash = {}
    @templateArray = templateArray
    templateArray.each { |t|
      if t.has_key?("name") and t.has_key?("OS") and t.has_key?("versionConstraints") and t["versionConstraints"].length>0 
        t["versionConstraints"].map!{|x| x = formatVersionConstraint(x)}
        @templateHash[t['name']] = t
      else
        puts "a template is missing key data and will be ignored"
      end
    }
  end
  def formatVersionConstraint(input)
    if input =~ /^([<=>]+)(.+)$/
      op = $1
      version = $2
      #replace "=" with "=="
      op.sub!(/^=$/, "==")
      #add quotes to version number
      if not version =~ /^['"]/
        version = "\"#{version}\""
      end
      return "#{op}#{version}"
    else
      raise "bad versionContraint format: #{input}"
    end
  end
  #a device's version number is compared against every versionConstraint
  #when all constraints are satisfied, the template is a match for the device
  def matchAVersionContraint(left, right)
    if not left =~ /^['"]/
      left = "\"#{left}\""
    end
    eval "#{left}#{right}"
  end
  def lookupTemplateFilename(device, component)
    templateFile = lookupTemplate2(device.OS, device.OSVersion, component.downcase)
  end
  def lookupTemplate(device, component)
    #match by device OS, OS version
    #check component template
    #if component template's not defined, lookup the template ancestor tree
    template = lookupTemplateFilename(device, component)
    #caching for performance improvement
    if not template.nil?
      return ERB.new File.new("template/#{template}").read, nil, "<>"
    else
      return nil
    end
  end
  def lookupTemplate2(os, osversion, component)
    t2=[]
    template = @templateArray.select{|x| x['OS']==os}
    template.each {|x|
      #every constraint has to match
      t2<<x unless x['versionConstraints'].map {|y| matchAVersionContraint(osversion, y)}.include? false
    }
    if t2.length==0
      puts "no template for #{os}, #{osversion}"
      return nil
    end
    if t2.length>1
      puts "more than one template for #{os}, #{osversion}"
      return nil
    end
    t = lookupTemplate3(t2[0]["name"], component)
    if t.nil?
      puts "no template for #{os}, #{osversion}. #{component}"
      return nil
    end
    return t
  end
  #look up the ancestor tree
  def lookupTemplate3(templateName, component)
    if @templateHash[templateName].has_key?("#{component}_template")
      return @templateHash[templateName]["#{component}_template"]
    else
      if @templateHash[templateName].has_key?("super_template") and @templateHash.has_key?(@templateHash[templateName]["super_template"])
        return lookupTemplate3(@templateHash[templateName]["super_template"], component)
      else
        return nil
      end
    end
  end
end