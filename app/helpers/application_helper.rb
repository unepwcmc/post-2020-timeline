module ApplicationHelper
  def site_title
    'The 2020 Biodiversity Strategic Planning Timeline'
  end 

  def site_description
    'This interactive timeline provides information on the various events leading to the adoption of a post-2020 global biodiversity framework. This new framework will be agreed at the Convention on Biological Diversity’s Conference of the Parties in 2020, guided by a large number of relevant meetings that inform and drive this process.'
  end

  def url_encode text
    ERB::Util.url_encode(text)
  end

  def encoded_home_url
    url_encode(request.base_url)
  end

  def social_image
    image_url('unep-wcmc-social-image.png')
  end

  def social_image_alt
    'Mangroves'
  end

  def create_social_facebook_link
    title = url_encode('Share ' + site_title + ' on Facebook')
    url = encoded_home_url
    href = 'https://facebook.com/sharer/sharer.php?u=' + url

    link_to '', href, title: title, class: 'icon--social icon--social-facebook', target: '_blank'
  end

  def create_social_linkedin_link
    title = url_encode('Share ' + site_title + ' on LinkedIn')
    url = encoded_home_url
    href = 'https://www.linkedin.com/shareArticle?url=' + url

    link_to '', href, title: title, class: 'icon--social icon--social-linkedin', target: '_blank'
  end

  def create_social_twitter_link
    title = url_encode('Share ' + site_title + ' on Twitter')
    text = url_encode('The post-2020 global biodiversity framework provides information on the various events leading to the adoption of a new Strategic Plan for Biodiversity.')
    url = encoded_home_url
    href = 'https://twitter.com/intent/tweet/?text=' + text + '&url=' + url
    
    link_to '', href, title: title, class: 'icon--social icon--social-twitter', target: '_blank'
  end

  def create_social_email_link
    title = url_encode('Share ' + site_title + ' via Email')
    url = encoded_home_url
    subject = url_encode(site_title)
    body = site_description + url_encode("\n\n") + url
    href = 'mailto:?subject=' + subject + '&body=' + body

    link_to '', href, title: title, class: 'icon--social icon--social-email', target: '_self'
  end
end
