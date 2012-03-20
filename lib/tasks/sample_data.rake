namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    users = User.all(limit: 5)
    50.times do
      title = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(100)
      users.each { |user| user.topics.create!(title: title, content: content) }
    end
  end
end