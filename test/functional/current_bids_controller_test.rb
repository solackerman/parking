require 'test_helper'

class CurrentBidsControllerTest < ActionController::TestCase
  setup do
    @current_bid = current_bids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_bids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_bid" do
    assert_difference('CurrentBid.count') do
      post :create, current_bid: { bid: @current_bid.bid, email: @current_bid.email, max_bid: @current_bid.max_bid, name: @current_bid.name, parking_spot: @current_bid.parking_spot }
    end

    assert_redirected_to current_bid_path(assigns(:current_bid))
  end

  test "should show current_bid" do
    get :show, id: @current_bid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @current_bid
    assert_response :success
  end

  test "should update current_bid" do
    put :update, id: @current_bid, current_bid: { bid: @current_bid.bid, email: @current_bid.email, max_bid: @current_bid.max_bid, name: @current_bid.name, parking_spot: @current_bid.parking_spot }
    assert_redirected_to current_bid_path(assigns(:current_bid))
  end

  test "should destroy current_bid" do
    assert_difference('CurrentBid.count', -1) do
      delete :destroy, id: @current_bid
    end

    assert_redirected_to current_bids_path
  end
end
