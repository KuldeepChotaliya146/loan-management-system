class DashboardController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_loan, only: %i[approve_loan change_loan_status]

  def index
    @admin = current_admin
    @wallet_balance = @admin.wallet_balance
    @loan_requests = Loan.requested.includes(:user)
    @active_loans = Loan.open.includes(:user)
    @repaid_loans = Loan.closed.includes(:user)
  end

  def approve_loan; end

  def change_loan_status
    case params[:status]
    when 'approved'
      handle_loan_approval
    when 'rejected'
      handle_loan_rejection
    else
      redirect_to_dashboard_with_alert('Invalid status')
    end
  end

  private

  def set_loan
    @loan = Loan.find_by(id: params[:loan_id])
    redirect_to_dashboard_with_alert('Loan not found') unless @loan
  end

  def handle_loan_approval
    if @loan.update(interest_rate: params[:interest_rate], status: :approved)
      redirect_to_dashboard_with_alert('Loan approved successfully!')
    else
      redirect_to_approval_page_with_alert(@loan)
    end
  end

  def handle_loan_rejection
    if @loan.update(status: :rejected)
      redirect_to_dashboard_with_alert('Loan rejected successfully!')
    else
      redirect_to_dashboard_with_alert(@loan.errors.full_messages.join(','))
    end
  end

  def redirect_to_dashboard_with_alert(alert_message)
    redirect_to dashboard_path, alert: alert_message
  end

  def redirect_to_approval_page_with_alert(loan)
    redirect_to admin_approve_loan_path(loan), alert: loan.errors.full_messages.join(',')
  end
end
