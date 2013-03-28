class ShowtasksController < InheritedResources::Base
  before_filter :authenticate_user!
  def index
    @showtasks = current_user.showtasks.with_tasks
  end

  def destroy
    # TODO check if user can manage this task
    super do |format|
      format.html { redirect_to root_url, :notice => "Shared task deleted successfully" }
    end
  end
end
