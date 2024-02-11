# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


url = 'https://github.com/mennockramer.atom'
item_hashes = []
URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)

  feed.items.each do |item|
    item_hash = Hash.from_xml(item.to_s)

    body = item_hash["entry"]["content"].gsub(/href="\//, "href=\"https://github.com/") # relative link fixing
    Post.new(title: item_hash["entry"]["title"], 
              body: body,
              posted_at: item_hash["entry"]["published"].to_datetime 
    ).save
  end  
end

