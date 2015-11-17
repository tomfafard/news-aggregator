require "sinatra"
require "csv"
require "pry"



get "/articles" do
  @news_articles = []
  @articles_from_csv = []

  @articles_from_csv = CSV.foreach('news_aggregator.csv', headers: true, header_converters: :symbol) do |row|
    @news_articles << row.to_hash
  end

  erb :articles
end

get "/articles/new" do

  erb :new
end


post "/articles/new" do
  title = params['article_title']
  url = params['article_url']
  description = params['article_description']

    CSV.open("news_aggregator.csv", "a") do |csv|
      csv << [title, url, description]
    end

    redirect "/articles"

end
