module ApplicationHelper
  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: '校長講話アイディアボックス',
      title: '心に残る校長講話を',
      # description: '校長講話アイディアボックスは、全国の校長先生がお持ちの講話アイディアを
      # 共有するプラットフォームです。',
      # reverse: true,
      charset: 'utf-8',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple_touch_icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: '校長講話アイディアボックス',
        # title: :title,
        # description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('kochokouwa_ogp.png'),
        locale: 'ja_JP'
      }
    }
  end
end
