if RUBY_VERSION < '1.9'
  $KCODE = 'u' 
  require 'jcode'
end

#
# irb configurations
#
require 'irb/completion'
require 'irb/ext/save-history'
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:HISTORY_FILE] = File.expand_path("~/.irb_history")
IRB.conf[:SAVE_HISTORY] = 100000

#
# extentions for irb
#
alias q exit

def require_safe(name)
  begin 
    require name 
  rescue LoadError
    puts %Q|gem "#{name}" is not found!|
  end
end

def stdout_ar
  ActiveRecord::Base.logger = Logger.new(STDOUT)  if defined? ActiveRecord
end

#
# Extends
#
class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

class Class
  def hierarchy
    (superclass ? superclass.hierarchy : []) << self
  end
end

#
# Standard libraries
#
require 'rubygems'
require 'pp'
require 'fileutils'
require 'ostruct'
require 'open-uri'
require 'yaml'
require 'csv'
require 'benchmark'

#
# Gems
#
require 'active_support'  # Include activesupport, then warning floods on script/console..
require_safe 'fastercsv'
require_safe 'hpricot'
require_safe 'ap'
require_safe 'net-http-spy'
require_safe 'method_source'

#
# Wirble
#
#require 'wirble'
#
##Wirble.init
##Wirble.colorize

#
# hirb
#
#require 'hirb/import_object'
#Hirb.enable
#extend Hirb::Console

#
# Boson
#
# require 'boson'
# Boson.start :verbose => false

#
# Bond
#
#require 'bond'
#Bond.start
