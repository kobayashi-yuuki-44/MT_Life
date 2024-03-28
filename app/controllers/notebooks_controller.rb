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
      @first_page = @notebook.pages.create(page_number: 1, page_content: 'ここに最初のページの内容を記入')
    end
  end

  private

  def notebook_params
    params.require(:notebook).permit(:title)
  end
end
