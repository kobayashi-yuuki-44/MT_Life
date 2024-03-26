class Page < ApplicationRecord
  before_save :sanitize_content
  
  belongs_to :notebook

  validates :page_number, presence: true

  private
  def sanitize_content
    self.page_content = ActionController::Base.helpers.sanitize(self.page_content)
  end
end
