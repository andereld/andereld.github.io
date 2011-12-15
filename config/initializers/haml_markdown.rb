module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require 'redcarpet'

  options = {
              :autolink => true,
              :no_intraemphasis => true,
              :superscript => true,
              :fenced_code => true,
              :gh_blockcode => true
            }
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)

  # using define_method rather than def to keep 'markdown' in scope
  define_method(:render) do |text|
    markdown.render(text)
  end
end
