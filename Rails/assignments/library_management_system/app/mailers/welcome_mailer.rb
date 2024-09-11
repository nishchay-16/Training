class WelcomeMailer < ApplicationMailer
  def welcome_email(book)
    @book = book
    mail(to: "nishchay.gupta@berylsystems.com", subject: 'Book Added to Library', from: "nishchay494@gmail.com")
  end
end
