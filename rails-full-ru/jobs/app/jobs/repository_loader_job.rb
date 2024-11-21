# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)
    client = Octokit::Client.new
    repository.start_fetch! if repository.created?
    repo_data = client.repo(extract_repo_name(repository.link))

    repository.update(
      repo_name: repo_data.name,
      description: repo_data.description,
      owner_name: repo_data.owner.login
    )
    repository.complete_fetch! if repository.fetching?
  rescue Octokit::NotFound
    Rails.logger.error "Repository not found: #{repository.link}"
    repository.update(state: 'failed')
  end

  private

  def extract_repo_name(link)
    URI.parse(link).path.delete_prefix('/')
  end
end
