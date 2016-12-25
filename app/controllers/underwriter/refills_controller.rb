class Underwriter::RefillsController < Underwriter::ApplicationController
  def index
    @borrowers = Account.where(account_type: :borrower)
  end

  def borrowers
    @borrowers = Account.where(account_type: :borrower).order('created_at DESC')
  end

  def investors
    @investors = Account.where(account_type: :investor).order('created_at DESC')
  end

  def borrower_refill
    ArdisTransaction.create(borrower_id: params[:id].to_i,
                            kind: :refill,
                            amount: params[:borrower][:amount].to_f)
    flash[:success] = 'Refill is successfully done.'
    redirect_to borrowers_underwriter_refills_path
  end

  def investor_refill
    ArdisTransaction.create(investor_id: params[:id].to_i,
                            kind: :refill,
                            amount: params[:investor][:amount].to_f)
    flash[:success] = 'Refill is successfully done.'
    redirect_to investors_underwriter_refills_path
  end
end
