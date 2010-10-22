module RussianAdaptationHelper
  def url_russian_post_tracking bar_code
    "http://info.russianpost.ru/servlet/post_item?action=search&searchType=barCode&barCode=#{bar_code}"
  end 

  def russian_post_delivery_status_link bar_code
    if bar_code
      link_to t(:order_delivery_status), url_russian_post_tracking(bar_code), {:target => :blank, :title => t(:order_delivery_status_according_to_russian_post)}
    else
      ''
    end
  end
end
