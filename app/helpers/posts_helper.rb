module PostsHelper
  def publication_date
    posted = @post.created_at.to_date
    updated = @post.updated_at.to_date

    if posted == updated
      "<time datetime='#{posted}' pubdate>Posted on #{posted}.</time>"
    else
      "<time datetime='#{posted}' pubdate>Posted on #{posted}. Updated on #{updated}</time>"
    end
  end
end
