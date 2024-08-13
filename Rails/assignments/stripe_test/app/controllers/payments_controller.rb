class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user_email = current_user.email if user_signed_in?
  end

  def success
  end

  def one_time_payment
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken]
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: 5000,
        description: 'One time Payment Plan',
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


  def recurring_payment
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken]
      })

      subscription = Stripe::Subscription.create({
        customer: customer.id,
        items: [
          {
            price: 'price_1PnKETA9XPncjDJ6Hpf1ouqq', 
          },
        ],
        expand: ['latest_invoice.payment_intent'],
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

  def index
    @subscriptions = Stripe::Subscription.list(customer: current_user.stripe_customer_id)
  end

end
