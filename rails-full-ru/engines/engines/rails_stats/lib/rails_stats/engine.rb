# frozen_string_literal: true

module RailsStats
  class Engine < ::Rails::Engine
    isolate_namespace RailsStats

    initializer :append_migrations do |app|
      app.config.paths['db/migrate'].concat(config.paths['db/migrate'].expanded) unless app.root.to_s.match? root.to_s
    end
  end
end
