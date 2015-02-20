require 'test_helper'

class OperationsControllerTest < ActionController::TestCase
  setup do
    @operation = operations(:one)
  end

  test "should get index" do
    get :index, account: @operation.account
    assert_response :success
    assert_not_nil assigns(:operations)
  end

  test "should get new" do
    get :new, account: @operation.account
    assert_response :success
  end

  test "should create operation" do
    assert_difference('Operation.count') do
      post :create, transaction_type: 0, operation: {account_id: @operation.account, date: @operation.date, amount: @operation.amount }
    end
    assert_redirected_to operation_path(assigns(:operation))
  end

  test "should show operation" do
    get :show, id: @operation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operation
    assert_response :success
  end

  test "should update operation" do
    patch :update, id: @operation, operation: { account_id: @operation.account_id, date: @operation.date, amount: @operation.amount, transfer_operation_id: @operation.transfer_operation_id }
    assert_redirected_to operation_path(assigns(:operation))
  end

  test "should destroy operation" do
    assert_difference('Operation.count', -1) do
      delete :destroy, id: @operation
    end
    assert_redirected_to account_operations_path(@operation.account)
  end
end
