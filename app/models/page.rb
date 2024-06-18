class Page < ApplicationRecord
  belongs_to :notebook
  has_many_attached :images, dependent: :destroy

  before_save :sanitize_content
  
  private
  
  def sanitize_content
    self.page_content = ActionController::Base.helpers.sanitize(self.page_content, tags: %w(p br strong em a img div), attributes: %w(src alt href style))
  end
end
