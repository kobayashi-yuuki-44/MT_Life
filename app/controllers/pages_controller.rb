class PagesController < ApplicationController
  before_action :set_notebook

  def new
    @page = @notebook.pages.new
  end

  def create
    last_page_number = @notebook.pages.maximum(:page_number) || 0
    @page = @notebook.pages.new(page_params.merge(page_number: last_page_number + 1))

    if @page.save
      render json: { id: @page.id, notebook_id: @notebook.id }, status: :created
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  def show
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @page = @notebook.pages.find_by(id: params[:id])
    unless @page
      redirect_to new_notebook_page_path(@notebook), alert: 'ページが見つかりませんでした。'
    end
  end

  def save_content
    @page = @notebook.pages.find_by(id: params[:id])
    if @page.update(page_content: params[:page][:content])
      render json: { status: 'success' }, status: :ok
    else
      render json: { errors: @page.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_notebook
    @notebook = current_user.notebooks.find(params[:notebook_id])
  end

  def page_params
    params.require(:page).permit(:page_content)
  end
end