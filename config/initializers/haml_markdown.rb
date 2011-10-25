module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require 'redcarpet'

  def render(text)
    options = [:autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html
  end
end
