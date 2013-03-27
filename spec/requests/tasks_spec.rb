require 'spec_helper'
include AuthSupport

describe "Tasks" do
  before :all do
    @user = FactoryGirl.create(:user)
    @sharer = FactoryGirl.create(:user, :sharer)
  end
  after :all do
    User.destroy_all
    Task.destroy_all
    Showtask.destroy_all
  end
  describe "sharer" do
    it "should ask authorization unless authorizes" do
      visit root_path
      page.should have_content("You need to sign in or sign up before continuing.")
    end

    describe "logged in" do
      before :each do
        log_in @sharer
      end

      it "should login successfully" do
        page.should have_content("Signed in successfully.")
      end

      it "should have empty list after login" do
        visit root_path
        page.should have_content("You have empty TODO list")
      end

      it "should open create task form", :js => true do
        visit root_path
        click_link "Add new task"
        page.should have_content("TODO item")
      end

      it "should create new task", :js => true do
        visit root_path
        click_link "Add new task"
        fill_in "task_title", :with => "test_task_1"
        fill_in "task_description", :with => "Test task 1 description"
        click_button "Save"
        @sharer.tasks.count.should == 1
      end
      
      it "should open edit dialog", :js => true do
        visit root_path
        click_link "Edit"
        page.should have_content("TODO item")
        find("#edit-task-modal").find_field("task_title").value.should == "test_task_1"
      end

      it "should update task", :js => true do
        visit root_path
        click_link "Edit"
        find("#edit-task-modal").find_field("task_title").set "test_task_1_updated"
        find("#edit-task-modal").click_button("Save")
        page.should have_content("test_task_1_updated")
      end

      it "should open share dialog", :js => true do
        visit root_path
        click_link "Share"
        page.should have_content("Enter email to share task")
      end

      it "should share task", :js => true do
        visit root_path
        click_link "Share"
        fill_in "email", :with => "user@example.com"
        click_button "Share"
        page.should have_content("Task successfully shared to user@example.com")
      end

      it "should not share task twice", :js => true do
        visit root_path
        click_link "Share"
        fill_in "email", :with => "user@example.com"
        click_button "Share"
        page.should have_content("This user (user@example.com) already has access to this task")
      end

      it "should not share task to unexistent user", :js => true do
        visit root_path
        click_link "Share"
        fill_in "email", :with => "nosuchuser@example.com"
        click_button "Share"
        page.should have_content("User with such email not found")
      end
    end
  end

  describe "user" do
    before :each do
      log_in @user
    end

    it "should have 1 shared by sharer@example.com task" do
      @user.tasks.count.should == 1
      showtask = @user.showtasks.first
      showtask.shared.should be_true
      visit root_path
      page.should have_content("shared by sharer@example.com")
    end

    it "should edit shared task", :js => true do
      click_link "Edit"
      find("#edit-task-modal").fill_in "task_title", :with => "test_task_1_updated_by_user"
      find("#edit-task-modal").click_button("Save")
      page.should have_content("test_task_1_updated_by_user")
    end
  end

  describe "sharer after user changes" do
    it "should be edited by user in sharer's accont" do
      log_in @sharer
      visit root_path
      page.should have_content("test_task_1_updated_by_user")
    end
  end
end
