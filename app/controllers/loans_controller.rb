class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: [:change_loan]

  def index
    @wallet_balance = current_user.wallet_balance
    @pagy, @loans = pagy(current_user.loans, items: 10)
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = current_user.loans.build(loan_params.merge(admin_id: Admin.first.id))

    if @loan.save
      redirect_to loans_path, notice: 'Loan requested successfully.'
    else
      flash[:alert] = @loan.errors.full_messages.join(', ')
      render :new
    end
  end

  def change_loan
    case params[:status]
    when 'open'
      open_loan
    when 'rejected'
      reject_loan
    else
      redirect_to loans_path, alert: 'Invalid loan status!'
    end
  end

  def repay
    @loan = current_user.loans.find_by(id: params[:id])
    amount_to_repay = @loan.total_amount
    if current_user.wallet_balance >= amount_to_repay
      ActiveRecord::Base.transaction do
        current_user.remove_amount(amount_to_repay)
        Admin.first.add_amount(amount_to_repay)
        @loan.update(status: :closed)
      end
      redirect_to loans_path, notice: 'Loan repaid successfully.'
    else
      redirect_to loans_path, alert: 'Loan can not be paid because your wallet has insufficent amount!'
    end
  end

  private

  def set_loan
    @loan = current_user.loans.find_by(id: params[:loan_id])
    redirect_to loans_path, alert: 'Loan not exist!' unless @loan
  end

  def loan_params
    params.require(:loan).permit(:reason, :status, :amount, :interest_rate)
  end

  def open_loan
    ActiveRecord::Base.transaction do
      Admin.first.subtract_amount(@loan.amount)
      current_user.add_amount(@loan.amount)
      @loan.update(status: :open, total_amount: @loan.amount, calculated_at: Time.now)
    end
    redirect_to loans_path, notice: 'Loan credited to your wallet!'
  end

  def reject_loan
    @loan.update(status: :rejected)
    redirect_to loans_path, notice: 'Loan rejected successfully!'
  end
end
