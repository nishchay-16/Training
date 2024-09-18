class CsvUploadWorker
  include Sidekiq::Worker

  def perform(csv_content)
    CSV.parse(csv_content, headers: true) do |row|
      email = row['email']
      Admin.create(emails: [email]) 
    end
  rescue => e
    Rails.logger.error "Error processing CSV file: #{e.message}"
  end
end