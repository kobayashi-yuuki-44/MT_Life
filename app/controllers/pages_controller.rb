class PagesController < ApplicationController
  before_action :set_notebook

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
end