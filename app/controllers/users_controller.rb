class UsersController < ApplicationController
  before_action :set_user, only:[:edit, :show, :update]
  before_action :logged_in_user, only:[:index, :edit, :show, :update]
  before_action :correct_user, only:[:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page:20)
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_path
    else
      render :edit
    end
  end

  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeフィルター
    def set_user
      @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
      end
    end
    
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
end
