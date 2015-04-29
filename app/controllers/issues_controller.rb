class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end

  def new
    @links = Link.without_issue.all
    if @links.size == 0
      redirect_to root_path
      return
    end
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(create_issue_params)
    if @issue.save
      # assign new Links to the Issue
      Link.without_issue.update_all(issue_id: @issue.id)

      redirect_to issues_path
    else
      render :new
    end
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update(update_issue_params)
      redirect_to issues_path
    else
      render :edit
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    redirect_to issues_path
  end

  private

  def create_issue_params
    params.require(:issue).permit(:title)
  end

  def update_issue_params
    params.require(:issue).permit(:title)
  end
end
