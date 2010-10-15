require 'active_record'
require 'active_record/migration'

module ActiveRecord::EngineSpec
  VERSION = '0.0.1'

  @@engine = :InnoDB
  @@force = false

  mattr_accessor :engine
  mattr_accessor :force

  module ClassMethods
    def create_table(*arguments, &block)
      arguments[1] = {} unless arguments[1]
      arguments[1][:options] = "" unless arguments[1][:options]

      if ActiveRecord::EngineSpec.force
        arguments[1][:options].sub!(/(^| )engine *= *[a-z_\-]+/i, "")
        arguments[1][:options] += " engine=#{ActiveRecord::EngineSpec.engine}"
      elsif /(^| )engine *= *[a-z_\-]+/i !~ arguments[1][:options]
        arguments[1][:options] += " engine=#{ActiveRecord::EngineSpec.engine}"
      end

      method_missing(:create_table, *arguments, &block)
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

class ActiveRecord::Migration
  include ActiveRecord::EngineSpec
end
