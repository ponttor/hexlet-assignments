# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Hexlet tasks'

  task :import_users, %i[data_path] => :environment do |_task, args|
    path = args[:data_path]

    abort 'Data path is required!' unless path
    puts path
    abort 'Cant find data file!' unless File.exist?(path)

    data = File.read(path)

    csv = CSV.parse(data, headers: true)
    csv.each do |row|
      parsed_birthday = DateTime.strptime(row['birthday'], '%m/%d/%Y')
      User.create!(row.to_hash.merge(birthday: parsed_birthday))
    end

    puts 'Successfuly loaded!'
  end
end