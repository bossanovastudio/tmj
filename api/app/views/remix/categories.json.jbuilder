json.array @categories do |category|
    json.id     category.id
    json.name   category.name
    json.url    category.cover.url
end
