# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
#
require 'faker'

puts "submissions destroyed #{Submission.count}" if Submission.destroy_all
puts "assignments destroyed #{Assignment.count}" if Assignment.destroy_all
puts "enrollments destroyed #{Enrollment.count}" if Enrollment.destroy_all
puts "forum posts destroyed #{ForumPost.count}" if ForumPost.destroy_all
puts "forum threads destroyed #{ForumThread.count}" if ForumThread.destroy_all
puts "materials destroyed #{Material.count}" if Material.destroy_all
puts "courses destroyed #{Course.count}" if Course.destroy_all
puts "instructors destroyed #{Instructor.count}" if Instructor.destroy_all
puts "students destroyed #{Student.count}" if Student.destroy_all

# Seed Instructors
5.times do
  Instructor.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password_digest: 'password',
    bio: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

# Seed Courses
20.times do
  Course.create!(
    name: Faker::Educator.course_name,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    instructor: Instructor.all.sample
  )
end

# Seed Students
30.times do
  Student.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Seed Enrollments
Course.all.each do |course|
  students = Student.all.sample(rand(5..15))
  students.each do |student|
    next if Enrollment.exists?(course:, student:)

    Enrollment.create!(
      course:,
      student:
    )
  end
end

# Seed Assignments
Course.all.each do |course|
  5.times do
    Assignment.create!(
      course_id: course.id,
      title: Faker::Educator.course_name,
      content: Faker::Lorem.paragraph(sentence_count: 5),
      due_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 7, period: :day)
    )
  end
end

# Seed Submissions
Assignment.all.each do |assignment|
  assignment.course.enrollments.each do |enrollment|
    Submission.create!(
      assignment:,
      enrollment: ,
      content: Faker::Lorem.paragraph(sentence_count: 5)
    )
  end
end

# Seed Materials
Course.all.each do |course|
  5.times do 
    Material.create!(
      course_id: course.id,
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph(sentence_count: 5)
    )
  end
end


# Seed Forum Threads
Course.all.each do |course|
  5.times do
    ForumThread.create!(
      course_id: course.id,
      title: Faker::Lorem.sentence
    )
  end
end

# Seed Forum Posts

Student.all.sample(rand(5..10)).each do |student|
  ForumThread.all.each do |thread|
    ForumPost.create!(
      forum_thread_id: thread.id,
      student_id: student.id,
      content: Faker::Lorem.paragraph(sentence_count: 5)
    )
  end
end

puts "submissions: #{Submission.count}"
puts "assignments: #{Assignment.count}"
puts "enrollments: #{Enrollment.count}"
puts "courses: #{Course.count}"
puts "instructors: #{Instructor.count}"
puts "students: #{Student.count}"
puts "forum threads: #{ForumThread.count}"
puts "forum posts: #{ForumPost.count}"
puts "materials: #{Material.count}"
