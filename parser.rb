require 'nokogiri'
require 'open-uri'

# doc = Nokogiri::HTML(open("https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/"))
doc = Nokogiri::HTML(open("denver_post_metro_districts.html"))

# paragraphs we want?

paragraphs = doc.css('.article-body').css('p')

sentences = paragraphs.map {|p| p.xpath('//*[contains(text(), "Metropolitan District")]') }

output = sentences.map do |sen|
  sen.map do |p|
    p.text
  end
end

# nailed it!
p output.first

# Aaron Patterson himself in 
# https://stackoverflow.com/questions/1556028/how-do-i-do-a-regex-search-in-nokogiri-for-text-that-matches-a-certain-beginning
# doc.xpath('//p[starts-with(@id, "para-")]').each { |x| puts x['id'] }

