require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_index_url
    assert_response :success
  end

  test "should get add_to_newsletter" do
    get articles_add_to_newsletter_url
    assert_response :success
  end

  test "should get remove_from_newsletter" do
    get articles_remove_from_newsletter_url
    assert_response :success
  end

  test "should get destroy" do
    get articles_destroy_url
    assert_response :success
  end
end
