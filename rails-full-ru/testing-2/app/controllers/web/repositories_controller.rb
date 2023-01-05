# frozen_string_literal: true

# BEGIN

# END

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    # BEGIN
    client = Octokit::Client.new(:access_token => "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")
    repo = Octokit.repo params[:repository][:link]
    
    repository = Repository.create(
      owner_name: repo.owner.login,
      default_branch: repo.default_branch,
      description: repo.description,
      repo_name: repo.name,
      link: params[:repository][:link],
      watchers_count: repo.watchers,
      language: repo.language,
      repo_created_at: repo.created_at,
      repo_updated_at: repo.updated_at
    )
    redirect_to repository
    # END
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
