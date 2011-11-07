class Post < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :presence => true,
                    :length   => { :maximum => 255 }
  validates :body,  :presence => true

  def trunc_title
    self.title.truncate(12, :seperator => ' ')
  end
end
