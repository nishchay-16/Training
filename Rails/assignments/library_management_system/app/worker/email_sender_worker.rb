class EmailSenderWorker
  include Sidekiq::Worker

  def perform(email)
    WelcomeMailer.welcome_email(email).deliver_now
  end
end