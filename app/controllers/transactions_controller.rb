class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'admin'
      @transactions = Transaction.all
    else
      @transactions = current_user.transactions
    end
    render json: @transactions
  end

  def create_transaction
    user_id = current_user.id
    transaction = Transaction.create_transaction(transaction_params, user_id)
    @transaction = current_user.transactions.last
    if transaction
      if transaction_params[:type].to_s == 'buy'
        render json: {message: 'Stock has been successfuly bought.', transaction: @transaction, status: 201}, status: 201
      else
        render json: {message: 'Stock has been successfuly sold.', transaction: @transaction, status: 201}, status: 201
      end
    else
      render json: {message: 'Not enough balance.'}, status: 400
    end
  end

  
  private

  def transaction_params
    params.require(:transaction).permit(:symbol, :shares, :type)
  end
end
