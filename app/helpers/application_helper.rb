module ApplicationHelper
  def pages_title(page_title = '')
    base_title = 'むしめがね'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def header_if_static_controller
    render 'shared/header' unless params[:controller] == 'static_pages'
  end

  def margin_if_static_controller
    'top_margin' unless params[:controller] == 'static_pages'
  end

  def flash_if_static_controller
    render 'shared/flash_message' unless params[:controller] == 'static_pages'
  end

  def default_meta_tags
    {
      site: 'むしめがね',
      title: 'むしめがね',
      reverse: true,
      separator: '|',
      description: '家の中にどんな虫がいるのか検索してみよう！',
      keywords: '',
      canonical: 'https://mushimegane.fun/',
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('mushimegane_top.jpeg') },
        { href: image_url('mushimegane_top.jpeg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: :canonical,
        image: image_url('mushimegane_top.jpeg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@UDZVsLKlP1jnUTk',
      }
    }
  end
end
