class WelcomeMailer < ApplicationMailer
  def welcome_email(email)
    mail(to: email, subject: 'Welcome to the Library', from: 'nishchay494@gmail.com')
  end
end
