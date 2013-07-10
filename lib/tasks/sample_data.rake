namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Example User",
                       email: "example@example.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "foobar"
    User.create!(name: name, email: email, password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do 
    content = Faker::Lorem.sentence(6)
    users.each do |user|
      user.microposts.create!(content: content)
    end
  end
end

def make_relationships
  users = User.all(limit: 6)
  users.each do |follower|
    users.each do |followed_user|
      follower.follow!(followed_user) unless follower == followed_user
    end
  end
end
