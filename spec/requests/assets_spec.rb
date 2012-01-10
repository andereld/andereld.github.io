require 'spec_helper'

describe "the website's static assets" do

  it "should include a favicon of type image/png" do
    get '/'
    response.should have_selector('link', :rel => 'shortcut icon',
                                          :type => 'image/png')
  end
end
