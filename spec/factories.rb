FactoryGirl.define do
  factory :user do
    name "Levey"
    email "levey.zhu@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :profile do
    realname "zhujiangang"
    location "Hangzhou"
    user
  end
  
  factory :topic do
    title "Hello World!"
    content "Hello World!Hello World!Hello World!Hello World!"
    hits 100
    user
  end
  
end

  