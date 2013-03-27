class ShowtasksController < InheritedResources::Base
  before_filter :authenticate_user!
  def index
    @showtasks = current_user.showtasks.with_tasks
  end

  def update
    super do |format|
      format.html { redirect_to root_url }
    end
  end

  def create
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
