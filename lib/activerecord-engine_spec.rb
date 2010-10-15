require 'pathname'

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
dir = Pathname(__FILE__).dirname.expand_path

require dir.join('active_record/engine_spec')
