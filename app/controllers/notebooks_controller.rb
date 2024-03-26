class NotebooksController < ApplicationController
  def index
    @notebooks = current_user.notebooks
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = current_user.notebooks.new(notebook_params)
    if @notebook.save
      redirect_to notebooks_path, notice: 'ノートが作成されました。'
    else
      render :new
    end
  end

  def show
    @notebook = current_user.notebooks.find(params[:id])
    @first_page = @notebook.pages.find_by(page_number: 1)
    unless @first_page
      redirect_to notebooks_path, alert: '最初のページが見つかりません。'
    end
  end

  private

  def notebook_params
    params.require(:notebook).permit(:title)
  end
end
