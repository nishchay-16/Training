class WelcomeMailer < ApplicationMailer
  def welcome_email
    mail(to: "abkb2023@gmail.com", subject: 'Welcome to Beryl Systems', from: "nishchay494@gmail.com")
  end
end
