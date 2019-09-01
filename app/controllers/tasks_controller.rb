class TasksController < ApplicationController
  before_action :logged_in, only:[:new, :create, :index, :edit, :update, :show, :destroy]
  before_action :correct_user, only[:new, :create, :index, :edit, :update, :show, :destroy]
  before_action :set_user, only:[:admin_or_correct_user, :index, :edit]
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index
    @tasks = Task.all
    @tasks = @user.tasks
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_path(@user, @task)
  end
  
    private
      def set_user
          @user = User.find(params[:user_id])
      end
      
      def task_params
        params.require(:task).permit(:task_name, :task_description)
      end
      
      def correct_user
        redirect_to(root_url) unless current_user?(@user)
      end
      
      def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
        end
      end
end
