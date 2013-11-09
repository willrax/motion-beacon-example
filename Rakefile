# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/ios"

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = "Beacon"
  app.device_family = [:iphone, :ipad]
  app.frameworks += ["CoreLocation", "CoreBluetooth"]
end
