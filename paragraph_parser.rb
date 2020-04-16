require 'nokogiri'
require 'open-uri'

class ParagraphParser
  attr_reader :doc, :paragraphs
  def initialize
    # doc = Nokogiri::HTML(open("https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/"))
    @doc = Nokogiri::HTML(open("denver_post_metro_districts.html"))
    @paragraphs = desired_paragraphs
  end

  def desired_paragraphs
    p = doc.css('.article-body').css('p').xpath('//*[contains(text(), "Metropolitan District")]')
    p.map { |f| f.text }
  end
end

