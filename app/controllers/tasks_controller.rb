class TasksController < InheritedResources::Base
  before_filter :authenticate_user!
  def index
    @tasks = current_user.tasks
  end

  def update
    super do |format|
      format.html { redirect_to root_url }
    end
  end

  def create
    @task = Task.new(params[:task])
    current_user.tasks << @task
    super do |format|
      format.html { redirect_to root_url }
    end
  end

  def edit
    super do |format|
      format.html { render layout: false }
    end
  end
end
