module Misc
  def traverseStructure(input, key=nil, block)
    if input.is_a?(Array)
      input.each {|x| traverseStructure(x, key, block)}
    elsif input.is_a?(Hash)
      input.each_pair {|k,v| traverseStructure(v, k, block)}
    else
      return block[input, key]
    end
  end
end
