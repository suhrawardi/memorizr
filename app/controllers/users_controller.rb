class UsersController < ApplicationController
 before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_filter :authenticate_user!

  def units
    @units = Unit.where(user: User.find(params[:id])).page(params[:page])
    @note = Note.new
    @attachment = Attachment.new
  end
  
  def show
    @user = User.find(params[:id])
  end
    def edit
    @user = User.find(params[:id])
  end
   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
            redirect_to @user
    else
      render 'edit'
    end
  
  def userindex
    @users = User.paginate(page: params[:page]) 
end
  end

 private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
