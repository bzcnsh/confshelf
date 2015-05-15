libdir = File.expand_path("../..", __FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'yaml'
