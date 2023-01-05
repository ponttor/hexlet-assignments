# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN

  def stub_api(link)
    response = File.new('test/fixtures/files/response.json')
    stub_request(:get, "https://api.github.com/repos/#{link}").
    to_return(body: response, status: 200)
  end
  
  test 'should_create' do

    stub_api('AlfieJones/theme-toggles')
    repository = repositories(:one)

    assert { repository.id == Repository.last.id }
    assert { repository.link == Repository.last.link }
    assert { repository.description == Repository.last.description }
    assert { repository.default_branch == Repository.last.default_branch }
    assert { repository.watchers_count == Repository.last.watchers_count }
    assert { repository.language == Repository.last.language }
  end
  # END
end
