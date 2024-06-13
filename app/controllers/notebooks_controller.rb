class NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show, :edit, :update, :destroy]

  def index
    @notebooks = current_user.notebooks.order(created_at: :desc)
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
    @page = @notebook.pages.first_or_create(page_content: 'ここに内容を記入')
  end

  def edit
  end

  def update
    if @notebook.update(notebook_params)
      redirect_to notebooks_path, notice: 'ノートが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @notebook.destroy
    redirect_to notebooks_path, notice: 'ノートが削除されました。'
  end

  private

  def set_notebook
    @notebook = current_user.notebooks.find(params[:id])
  end

  def notebook_params
    params.require(:notebook).permit(:title)
  end
end
