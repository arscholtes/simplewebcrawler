# Language: Ruby, Level: Level 4
require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "http://www.indyhackers.org/jobs"
  unparsed_page = HTTParty.get(url)
  parsed_page   = Nokogiri::HTML(unparsed_page)
  jobs = Array.new
  job_listings  = parsed_page.css('li')
  job_listings.each do |job_listing|
      job = {
        title: job_listing.css('span').text,
        salary: job_listing.css('span.salary').text,
        url: "https://www.indyhackers.com" + job_listing.css('a')[0].attributes["href"].value
      }
      jobs << job
  end
  byebug
end

scraper
