class TasksController < ApplicationController
  
  before_action :set_user
  before_action :set_task, only:[:edit, :update, :show, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  
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
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
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
      
      def set_task
        unless @task = @user.tasks.find_by(id: params[:id])
          flash[:danger] = "権限がありません。"
          redirect_to user_tasks_url @user
        end
      end
end
