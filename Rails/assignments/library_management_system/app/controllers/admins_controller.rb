require 'csv'

class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to new_admin_path
    end
  end

  def upload_csv
    @admin = Admin.new(admin_params)
  
    csv_file = @admin.csv_file.file
    permanent_file_path = Rails.root.join('public', 'uploads', csv_file.filename.to_s)
    File.open(permanent_file_path, 'wb') do |file|
      file.write(csv_file.read) 
    end

    CsvUploadWorker.perform_async(permanent_file_path.to_s)
  
    redirect_to new_admin_path, notice: 'CSV file is being processed.'
  end
  

  private

  def process_csv(file_path)
    CsvUploadWorker.perform_async(file_path) # Pass the CSV file path to Sidekiq worker
  end

  def admin_params
    params.require(:admin).permit(:scheduled_time, :csv_file , emails: [])
  end
end