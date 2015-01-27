class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  class TransactionType
    def TransactionType.add_item(key,value)
      @hash ||= {}
      @hash[key] = value
    end

    def TransactionType.const_missing(key)
      @hash[key]
    end    

    def TransactionType.each
      @hash.each { |key,value| yield(key,value) }
    end

    TransactionType.add_item :EXPENDITURE, 0
    TransactionType.add_item :INCOME, 1
    TransactionType.add_item :TRANSFER, 2
  end

  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @transaction_type = TransactionType::EXPENDITURE
    @operation = Operation.new
    @transfer_account = Account.new
  end

  # GET /operations/1/edit
  def edit
    if @transaction_type == TransactionType::TRANSFER
      if (@operation.amount > 0) # Edit always via the expenditure operation
        @operation, @transfer_operation = @transfer_operation, @operation
      end
      @transfer_account = @operation.transfer_operation.account
    end
    @operation.amount = @operation.amount.abs
  end

  # POST /operations
  # POST /operations.json
  def create
    @transaction_type = params[:transaction_type].to_i
    @operation = Operation.new(operation_params)
    @transfer_operation = Operation.new(transfer_operation_params) if (TransactionType::TRANSFER == @transaction_type)
    saved = false
    Operation.transaction do
      saved = @operation.save
      if (saved && @transfer_operation)
        @transfer_operation.transfer_operation = @operation
        saved &= @transfer_operation.save
        if (saved)
          saved &= @operation.update transfer_operation: @transfer_operation
        end
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operation }
      else
        format.html { render action: 'new' }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  def update
    new_transaction_type = params[:transaction_type].to_i
    saved = false
    Operation.transaction do
      if (@transaction_type == new_transaction_type) || (@transaction_type != TransactionType::TRANSFER && new_transaction_type != TransactionType::TRANSFER)
        saved = @operation.update(operation_params(new_transaction_type))
        saved &= @operation.transfer_operation.update(transfer_operation_params) if saved && (TransactionType::TRANSFER == @transaction_type)
      elsif @transaction_type == TransactionType::TRANSFER
        @transfer_operation = @operation.transfer_operation
        @operation.transfer_operation = nil;        
        saved = @operation.update(operation_params(new_transaction_type))
        @transfer_operation.destroy
        @transfer_operation = nil
      elsif new_transaction_type == TransactionType::TRANSFER
        saved = @operation.update(operation_params(new_transaction_type))
        if saved
          @transfer_operation = Operation.new(transfer_operation_params)
          @transfer_operation.transfer_operation = @operation
          saved &= @transfer_operation.save
          if (saved)
            saved &= @operation.update transfer_operation: @transfer_operation
          end
        end
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url }
      format.json { head :no_content }
    end
  end

  private
    # Set operation from input parameters
    def set_operation
      @operation = Operation.find(params[:id])
      @transfer_operation = @operation.transfer_operation
      if @transfer_operation
        @transaction_type = TransactionType::TRANSFER
      elsif @operation.amount > 0
        @transaction_type = TransactionType::INCOME
      else
        @transaction_type = TransactionType::EXPENDITURE
      end      
    end

    def operation_params(transaction_type = nil)
      transaction_type ||= @transaction_type
      case transaction_type
      when TransactionType::EXPENDITURE, TransactionType::TRANSFER
        {account_id: params[:operation][:account_id], amount: -params[:operation][:amount].to_f, date: params[:operation][:date]}
      when TransactionType::INCOME
        {account_id: params[:operation][:account_id], amount: params[:operation][:amount].to_f, date: params[:operation][:date]}
      end
    end

    def transfer_operation_params
      {account_id: params[:transfer_account][:id], amount: params[:operation][:amount].to_f, date: params[:operation][:date]}
    end
  end
