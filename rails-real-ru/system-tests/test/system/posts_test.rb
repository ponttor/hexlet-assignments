# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  setup do
    @attrs = {
      title: Faker::Book.title,
      body: Faker::Books::Dune.quote
    }
  end

  test 'visiting the index' do
    visit posts_path
    assert_selector 'h1', text: 'Posts'
  end

  test 'creating a Post' do
    visit posts_path
    click_on 'New Post'

    fill_in 'Title', with: @attrs[:title]
    fill_in 'Body', with: @attrs[:body]
    click_on 'Create Post'

    assert_text 'Post was successfully created.'
    click_on 'Back'

    post = Post.find_by! title: @attrs[:title]
    assert { post }
  end

  test 'updating a Post' do
    visit posts_path
    click_on 'Edit', match: :first

    fill_in 'Title', with: @attrs[:title]
    fill_in 'Body', with: @attrs[:body]
    click_on 'Update Post'

    assert_text 'Post was successfully updated.'
    click_on 'Back'

    post = Post.find_by! title: @attrs[:title]
    assert { post }
  end

  test 'destroying a Post' do
    post_count_before = Post.count
    visit posts_path
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Post was successfully destroyed'

    post_count_after = Post.count
    assert { post_count_after == post_count_before - 1 }
  end

  test 'creatign comment on a post' do
    visit posts_path
    click_on 'Show', match: :first
    fill_in 'post_comment_body', with: @attrs[:body]
    click_on 'Create Comment'
    assert_text 'Comment was successfully created.'

    comment = Post::Comment.find_by body: @attrs[:body]
    assert { comment }
  end
end
# END
