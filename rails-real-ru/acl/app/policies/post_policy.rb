# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def new?
    user
  end

  def create?
    user
  end

  def edit?
    admin? || author?
  end

  def update?
    admin? || author?
  end

  def destroy?
    admin?
  end

  private

  def author?
    record.author == user
  end

  def admin?
    user&.admin?
  end
  # END
end
