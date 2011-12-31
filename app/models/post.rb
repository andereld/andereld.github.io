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

  def trunc_title
    title.truncate(12, :seperator => ' ')
  end

  def publication_date_in_html
    if created_at == updated_at
      "<time datetime='#{created_at.to_date}' pubdate>" +
        "Posted on #{created_at.to_date}." +
      "</time>"
    else
      "<time datetime='#{created_at.to_date}' pubdate>" +
        "Posted on #{created_at.to_date}; edited on #{updated_at.to_date}." +
      "</time>"
    end
  end
end
