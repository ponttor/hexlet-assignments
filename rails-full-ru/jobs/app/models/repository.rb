# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :link, presence: true, uniqueness: true

  # BEGIN
  @repository = Repository.new(permitted_params)

  if @repository.save
    RepositoryLoaderJob.perform_later(@repository.id)
    redirect_to repository_path(@repository), notice: t('repositories.create.success')
  else
    flash.now[:alert] = t('repositories.create.fail')
    render :new
  end
  # END
end
