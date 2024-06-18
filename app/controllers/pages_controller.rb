class PagesController < ApplicationController
  before_action :set_notebook, only: [:new, :create, :show, :save_content, :upload_image]

  def new
    @page = @notebook.pages.new
  end

  def create
    @page = @notebook.pages.new(page_params)
    if @page.save
      redirect_to notebook_path(@notebook), notice: 'ページが作成されました。'
    else
      render :new
    end
  end

  def show
    @page = @notebook.pages.first
  end

  def save_content
    @page = @notebook.pages.first
    SavePageContentJob.perform_later(@page.id, params[:page][:content])
    render json: { status: 'success' }, status: :ok
  end

  def upload_image
    @page = @notebook.pages.find(params[:page_id])
    if params[:image].present?
      @page.images.attach(params[:image])
      image_url = url_for(@page.images.last)
      render json: { url: image_url, insert_at: params[:insert_at] }, status: :ok
    else
      render json: { error: '画像が選択されていません。' }, status: :unprocessable_entity
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