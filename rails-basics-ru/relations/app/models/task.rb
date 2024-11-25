# frozen_string_literal: true

class Task < ApplicationRecord
  # BEGIN
  belongs_to :status
  belongs_to :user
  # END
end
