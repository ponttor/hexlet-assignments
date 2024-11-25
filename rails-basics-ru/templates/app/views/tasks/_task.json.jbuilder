# frozen_string_literal: true

json.extract! task, :id, :name, :description, :status, :creator, :performer, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
