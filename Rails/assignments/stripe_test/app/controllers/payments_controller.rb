class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @user_email = current_user.email if user_signed_in?
  end

  def create
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken]
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: 50000,
        description: 'Description of your product',
        currency: 'usd'
      })

      flash[:success] = "Payment successful!"
      redirect_to success_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    rescue Stripe::StripeError => e
      flash[:error] = "Stripe error: #{e.message}"
      redirect_to new_payment_path
    rescue => e
      flash[:error] = "An error occurred: #{e.message}"
      redirect_to new_payment_path
    end
  end

  def success
  end
end
