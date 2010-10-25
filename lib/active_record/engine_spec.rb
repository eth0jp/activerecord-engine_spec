require 'active_record'
require 'active_record/migration'

module ActiveRecord::EngineSpec
  VERSION = '0.0.3'

  @@engine = :InnoDB
  @@force = false

  mattr_accessor :engine
  mattr_accessor :force

  module ClassMethods
    def create_table(*arguments, &block)
      begin
        if ActiveRecord::Base.connection.adapter_name.downcase.index("mysql")
          arguments[1] = {} unless arguments[1]
          arguments[1][:options] = "" unless arguments[1][:options]

          if ActiveRecord::EngineSpec.force
            arguments[1][:options].sub!(/(^| )engine *= *[a-z0-9_\-]+/i, "")
            arguments[1][:options] += " engine=#{ActiveRecord::EngineSpec.engine}"
          elsif /(^| )engine *= *[a-z0-9_\-]+/i !~ arguments[1][:options]
            arguments[1][:options] += " engine=#{ActiveRecord::EngineSpec.engine}"
          end
        end
      rescue
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
