require 'test_helper'

class Public::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_contacts_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_contacts_confirm_url
    assert_response :success
  end

  test "should get back" do
    get public_contacts_back_url
    assert_response :success
  end

  test "should get create" do
    get public_contacts_create_url
    assert_response :success
  end

end
