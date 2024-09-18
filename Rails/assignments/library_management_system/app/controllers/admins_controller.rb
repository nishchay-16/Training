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
    csv_file = params[:admin][:csv_file]

    if csv_file.present?
      csv_content = csv_file.read # Read file content

      # Perform CSV upload in background
      CsvUploadWorker.perform_async(csv_content) # Pass the file content to Sidekiq worker
      redirect_to new_admin_path, notice: 'CSV file is being processed.'
    else
      render :new, alert: 'Please upload a CSV file.'
    end
  end

  private

  def process_csv(file_path)
    CsvUploadWorker.perform_async(file_path) # Pass the CSV file path to Sidekiq worker
  end

  def admin_params
    params.require(:admin).permit(:scheduled_time, :csv_file , emails: [])
  end
end