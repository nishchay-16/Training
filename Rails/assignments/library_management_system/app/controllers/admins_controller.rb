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

  private

  def admin_params
    params.require(:admin).permit(:scheduled_time, emails: [])
  end
end