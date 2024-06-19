module ApplicationHelper

  def flash_class(type)
    base_classes = "font-yuji-syuku p-4 text-lg"
    color_class = case type
                  when 'notice' then 'bg-flash-yellowgreen text-custom-wordbook-edit-text'
                  when 'success' then 'bg-flash-yellowgreen text-custom-wordbook-edit-text'
                  when 'error' then 'bg-flash-darkred'
                  when 'warning' then 'bg-yellow-500'
                  when 'danger' then 'bg-flash-darkred'
                  else 'bg-flash-purple text-custom-memo-text'
                  end
    "#{base_classes} #{color_class}"
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
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.png')
      }
    }
  end
end
