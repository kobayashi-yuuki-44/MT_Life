class QuestionsController < ApplicationController
  def index
  end

  def field
    @fields = [
      '臨床検査総論',
      '臨床検査医学総論',
      '臨床生理学',
      '臨床化学',
      '病理組織細胞学',
      '臨床血液学',
      '臨床微生物学',
      '臨床免疫学',
      '公衆衛生学',
      '医用工学概論'
    ]
  end

  def year
  end

  def random
  end
end
