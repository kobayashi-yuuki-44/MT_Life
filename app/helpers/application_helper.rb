module ApplicationHelper

  def flash_class(type)
    case type
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'warning' then 'alert alert-warning'
    when 'danger' then 'alert alert-danger'
    else 'alert'
    end
  end

  def page_title(title)
    base_title = 'MTLife'

    title.empty? ? base_title : title + " | " + base_title
  end
  
  def default_meta_tags
    {
      site: 'MTLife',
      title: '臨床検査技師国家試験対策学習サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'MTLifeで臨床検査技師国家試験対策をスマートに。分野別・年代別の問題選択から、メモ・ノート作成、単語帳機能まで、全方位からサポートします',
      keywords: '臨床検査技師,国家試験,対策,学習,単語',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        title: 'MTLife',
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
