# == Schema Information
# Schema version: 20111227213120
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#  body       :text
#  image      :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :title, :body, :image, :remove_image
  mount_uploader :image, ImageUploader

  validates :title, :presence => true,
                    :length   => { :maximum => 255 }
  validates :body,  :presence => true

  def pubdate
    created_at.to_date
  end

  def to_html
    # for some reason, '\n' is simply removed by the call to render, 
    # concatenating the words that surround it, hence the translation
    Haml::Filters::Markdown.render(body.tr("\n", " "))
  end
end
