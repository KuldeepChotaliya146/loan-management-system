class LoansController < ApplicationController
  before_action :authenticate_user!

  def index
    @loans = current_user.loans
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.new(loan_parms.merge!(user_id: current_user.id, admin_id: Admin.first.id))
    if @loan.valid?
      @loan.save
      redirect_to loans_path, notice: 'Loan requested successfully.'
    else
      p "@loan.errors.full_messages--->#{@loan.errors.full_messages}"
      flash[:notice] = @loan.errors.full_messages.join(', ')
      redirect_to new_loan_path
    end
  end

  private

  def loan_parms
    params.require(:loan).permit(:reason, :status, :amount, :interest_rate)
  end
end
