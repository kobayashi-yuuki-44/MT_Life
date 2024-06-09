class DiariesController < ApplicationController
  before_action :require_login
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    if params[:date]
      @date = Date.parse(params[:date])
      @diaries = current_user.diaries.where(start_time: @date.all_day).order(created_at: :desc)
    else
      @diaries = current_user.diaries.order(created_at: :desc)
    end
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @diary = Diary.new(start_time: params[:start_time])
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append('calendar_frame', partial: 'diaries/calendar', locals: { date: @diary.start_time.to_date, diaries: [@diary] }) }
        format.html { redirect_to calendar_diaries_path, notice: '日記を作成しました' }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_diary_form', partial: 'diaries/form', locals: { diary: @diary }) }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    if @diary.update(diary_params)
      respond_to do |format|
        format.html { redirect_to @diary, notice: '日記を更新しました' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("diary_frame_#{@diary.id}", partial: "diaries/show", locals: { diary: @diary }) }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("diary_frame_#{@diary.id}", partial: "diaries/form", locals: { diary: @diary }) }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace('calendar_frame', partial: "diaries/show", locals: { diary: @diary }) }
    end
  end

  def destroy
    date = @diary.start_time.to_date
    @diary.destroy
    respond_to do |format|
      format.html { redirect_to diaries_url(date: date), notice: '日記を削除しました' }
      format.turbo_stream {
        @diaries = current_user.diaries.where(start_time: date.all_day).order(created_at: :desc)
        flash.now[:notice] = '日記を削除しました'
        render turbo_stream: [
          turbo_stream.remove(@diary),
          turbo_stream.replace("flash", partial: "shared/flash_message")
        ]
      }
    end
  end

  def calendar
    @date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @diaries = current_user.diaries.where(start_time: @date.all_month)
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:diaries_title, :diaries_content, :start_time)
  end
end
