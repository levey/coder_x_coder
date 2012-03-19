namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    users = User.all(limit: 5)
    50.times do
      title = Faker::Lorem.sentence(5)
      users.each { |user| user.topics.create!(title: title) }
    end
  end
end