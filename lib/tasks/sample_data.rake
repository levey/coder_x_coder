namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    users = User.all(limit: 5)
    50.times do
      title = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(100)
      users.each do |user|
        topic = user.topics.build(title: title, content: content) 
        topic.save
        50.times do 
          comment_content = Faker::Lorem.sentence(30)
          topic.comments.create!(user: user, topic: topic, content:comment_content)
        end
      end
    end
  end
end