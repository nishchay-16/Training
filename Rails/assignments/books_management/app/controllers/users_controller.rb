class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_avatar
    if current_user.update(avatar_params)
      redirect_to edit_user_registration_path, notice: 'Profile picture updated successfully.'
    else
      flash[:alert] = current_user.errors.full_messages.to_sentence
      redirect_to edit_user_registration_path
    end
  end

  def remove_avatar
    current_user.avatar.purge
    redirect_to edit_user_registration_path, notice: 'Profile picture removed successfully.'
  end

  def upload_attachments
    @user = current_user
  end

  def save_attachments
    @user = current_user
    if @user.update(attachments_params)
      redirect_to upload_attachments_user_path(@user), notice: 'Attachments uploaded successfully.'
    else
      render :upload_attachments
    end
  end

  private

  def avatar_params
    params.require(:user).permit(:avatar)
  end

  def attachments_params
    params.require(:user).permit(attachments: [])
  end
end