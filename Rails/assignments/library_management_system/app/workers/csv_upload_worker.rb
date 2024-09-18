require 'csv'

class CsvUploadWorker
  include Sidekiq::Worker

  def perform(csv_file_path)
    if File.exist?(csv_file_path)
      CSV.foreach(csv_file_path, headers: true) do |row|
        email = row['email']
        
        Admin.create(emails: [email]) if email.present?
      end
      File.delete(csv_file_path)
    else
      Rails.logger.error "CSV file not found at path: #{csv_file_path}"
    end
  rescue StandardError => e
    Rails.logger.error "Error processing CSV file: #{e.message}"
  end
end