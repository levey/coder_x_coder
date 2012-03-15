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
  
end

  