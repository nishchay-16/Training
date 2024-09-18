class Admin < ApplicationRecord
  after_save :send_welcome_emails

  private

  def send_welcome_emails
    self.emails.each do |email|
      if scheduled_time.present?
        utc_scheduled_time = scheduled_time.in_time_zone('Kolkata').utc
        EmailSenderWorker.perform_at(utc_scheduled_time, email)
      else
        EmailSenderWorker.perform_async(email)
      end
    end
  end
end
