# == Schema Information
# Schema version: 20111107022547
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :presence => true,
                    :length   => { :maximum => 255 }
  validates :body,  :presence => true

  def trunc_title
    self.title.truncate(12, :seperator => ' ')
  end
end
