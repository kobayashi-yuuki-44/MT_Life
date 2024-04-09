# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

CSV.foreach(Rails.root.join('db', 'questions.csv'), headers: true) do |row|
  Question.find_or_create_by(
    question_text: row['question_text'],
    year: row['year'],
    subject: row['subject'],
  )
end

CSV.foreach(Rails.root.join('db', 'options.csv'), headers: true) do |row|
  option = Option.find_or_create_by(
    question_id: row['question_id'],
    option_text: row['option_text']
  ) do |option|
    option.position = row['position']
  end
  option.update(position: row['position']) unless option.new_record?
end

CSV.foreach(Rails.root.join('db', 'question_correct_answers.csv'), headers: true) do |row|
  QuestionCorrectAnswer.find_or_create_by(
    question_id: row['question_id'],
    correct_answer: row['correct_answer'],
  )
end

CSV.foreach(Rails.root.join('db', 'image_questions.csv'), headers: true) do |row|
  ImageQuestion.find_or_create_by(
    question_id: row['question_id'],
    image_url: row['image_url']
  )
end