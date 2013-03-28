class TasksController < InheritedResources::Base
  before_filter :authenticate_user!
  def index
    @tasks = current_user.tasks
  end

  def update
    # TODO check if user can manage this task
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

  def destroy
    # TODO check if user can manage this task
    super do |format|
      format.html { redirect_to root_url }
    end
  end

  def edit
    super do |format|
      format.html { render layout: false }
    end
  end

  def share
    # TODO check if user can manage this task
    email = params[:email]
    @task = Task.find(params[:id])
    error = @task.share(email, current_user)
    if error
      flash[:error] = error
    else
      flash[:notice] = "Task successfully shared to #{email}"
    end
    redirect_to root_url
  end

  def share_form
    @task = Task.find(params[:id])
    render :layout => false
  end
end
