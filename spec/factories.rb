FactoryGirl.define do
  factory :user do
    username "Levey"
    email "levey.zhu@gmail.com"
    password "foobar"
  end
  
  factory :profile do
    realname "zhujiangang"
    location "Hangzhou"
    user
  end
  
  factory :topic do
    title "Hello!"
    content "World!"
    user
  end
  
  # factory :comment do
  #   content "Hello World!Hello World!Hello World!Hello World!"
  #   user
  #   topic
  # end
  
end

  