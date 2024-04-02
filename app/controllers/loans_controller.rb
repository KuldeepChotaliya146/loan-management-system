class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: [:change_loan]

  def index
    @wallet_balance = current_user.wallet_balance
    @loans = current_user.loans
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
    when "open"
      open_loan
    when "rejected"
      reject_loan
    else
      redirect_to loans_path, alert: "Invalid loan status!"
    end
  end

  private

  def set_loan
    @loan = current_user.loans.find_by(id: params[:loan_id])
    redirect_to loans_path, alert: "Loan not exist!" unless @loan
  end

  def loan_params
    params.require(:loan).permit(:reason, :status, :amount, :interest_rate)
  end

  def open_loan
    ActiveRecord::Base.transaction do
      Admin.first.subtract_amount(@loan.amount)
      current_user.add_amount(@loan.amount)
      @loan.update(status: :open)
    end
    redirect_to loans_path, notice: "Loan credited to your wallet!"
  end

  def reject_loan
    @loan.update(status: :rejected)
    redirect_to loans_path, notice: 'Loan rejected successfully!'
  end
end
