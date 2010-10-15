require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/activerecord-engine_spec'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'activerecord-engine_spec' do
  self.developer 'Yoshida Tetsuya', 'tetu@eth0.jp'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  # self.extra_deps         = [['activesupport','>= 2.0.2']]
  self.extra_deps           = [['activerecord','>= 2.0.0']]

end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]
