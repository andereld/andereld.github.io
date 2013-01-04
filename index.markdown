---
layout: default
title: ~andereld
---

{% highlight c %}

int main(void)
{
    puts("hello, world");
}

{% endhighlight %}

{% highlight ruby %}

#!/usr/bin/env ruby
# encoding: utf-8

require 'date'
require 'net/http'
require 'nokogiri'

ForecastURI = URI('http://www.yr.no/sted/Norge/S%C3%B8r-Tr%C3%B8ndelag/' +
                  'Trondheim/Elgeseter/varsel_time_for_time.xml')
NumOfHours  = ARGV.any? ? ARGV[0].to_i : 10

xml  = Net::HTTP.get(ForecastURI)
data = Nokogiri.XML(xml)

location    = data.at_css('weatherdata location name').content
last_update = DateTime.parse(data.at_css('weatherdata meta lastupdate').content)
intervals   = data.css('weatherdata forecast tabular').children.select do |c|
    # The <time> nodes we're interested in are represented by instances of
    # Nokogiri::XML::Element. The whitespace between them is represented by
    # instances of Nokogiri::XML::Text; we have no use for these.
    c.element?
end.take(NumOfHours)

puts "Forecast from yr.no", "\n"
puts "Location:\t#{location}"
puts "Last update:\t#{last_update.strftime('%Y-%m-%d %H:%M')}", "\n"

intervals.each do |i|
    from   = DateTime.parse(i[:from]).strftime('%H:%M')
    to     = DateTime.parse(i[:to]).strftime('%H:%M')
    temp   = i.at_css('temperature')[:value]
    precip = i.at_css('precipitation')[:value]

    puts sprintf("%s — %s\t%2s°C\t%3s mm", from, to, temp, precip)
end

{% endhighlight %}
