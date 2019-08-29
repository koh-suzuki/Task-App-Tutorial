# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end


Task.create!( task_name: "task1",
              task_description: "タスクの作成")

50.times do |n|
  task_name  = Faker::Name.task_name
  task_description = "タスクの作成(#{n+1})"
  Task.create!(task_name: task_name,
               task_description: task_description)
end