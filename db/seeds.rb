User.destroy_all
Kondate.destroy_all
Image.destroy_all

users = []
10.times do |i|
  users << User.create!(name: "クック#{i}", password_digest: DigestGenerator.digest("password"))
end

image = Image.create!(
  body: File.binread(Rails.root.join('spec/fixtures/recipe.jpg')),
  filename: 'recipe.jpg'
)

recipes = []
%w[
  絶対失敗しないマカロン
  簡単に作れる肉じゃが
  美味しいアイスポックスクッキー
  混ぜるだけ！ベイクドチーズケーキ
  真っ白レアチーズケーキ
  しっとりダックワーズ
  基本のプレーンマフィン
  豆腐ドーナツ
  いつもの唐揚げ
  時間外フィナンシェ
].each do |recipe_title|
  user = users.sample
  recipes << Recipe.create!(
    title: recipe_title,
    user_id: user.id,
    image_id: image.id,
    description: "#{recipe_title}の作り方",
    steps: rand(1..4).times.map do |i|
      Step.new(description: "手順 #{i + 1}", position: i)
    end,
    ingredients: rand(1..4).times.map do |i|
      Ingredient.new(name: "材料 #{i + 1}", quantity: "#{i * 10}g", position: i)
    end
  )
end

20.times do |i|
  recipe = recipes.sample
  user = users.reject { |u| u.id == recipe.user_id }.sample
  Tsukurepo.create!(
    recipe_id: recipe.id,
    user_id: user.id,
    image_id: recipe.image_id,
    comment: "#{recipe.title}、とても作りやすかったです！"
  )
end

10.times do |i|
  main_dish = recipes.sample
  Kondate.create!(
    title: "献立#{i}",
    description: "献立#{i}の説明",
    main_dish_id: main_dish.id
  )
end
