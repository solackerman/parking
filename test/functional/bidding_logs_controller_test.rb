require 'test_helper'

class BiddingLogsControllerTest < ActionController::TestCase
  setup do
    @bidding_log = bidding_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bidding_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bidding_log" do
    assert_difference('BiddingLog.count') do
      post :create, bidding_log: { email: @bidding_log.email, location: @bidding_log.location, max_bid: @bidding_log.max_bid, name: @bidding_log.name, placed_at: @bidding_log.placed_at, spot: @bidding_log.spot }
    end

    assert_redirected_to bidding_log_path(assigns(:bidding_log))
  end

  test "should show bidding_log" do
    get :show, id: @bidding_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bidding_log
    assert_response :success
  end

  test "should update bidding_log" do
    put :update, id: @bidding_log, bidding_log: { email: @bidding_log.email, location: @bidding_log.location, max_bid: @bidding_log.max_bid, name: @bidding_log.name, placed_at: @bidding_log.placed_at, spot: @bidding_log.spot }
    assert_redirected_to bidding_log_path(assigns(:bidding_log))
  end

  test "should destroy bidding_log" do
    assert_difference('BiddingLog.count', -1) do
      delete :destroy, id: @bidding_log
    end

    assert_redirected_to bidding_logs_path
  end
end
