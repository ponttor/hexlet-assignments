# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def create?
    user
  end

  def show?
    true
  end

  def update?
    record.author_id == user&.id || user&.admin?
  end

  def destroy?
    user&.admin?
  end
  # END
end
