# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

['2023', '2022', '2021'].each do |year|
  CSV.foreach(Rails.root.join('db', "questions#{year}.csv"), headers: true) do |row|
    Question.create!(
      question_text: row['question_text'],
      year: row['year'],
      subject: row['subject']
    )
  end
end

['2023', '2022', '2021'].each do |year|
  CSV.foreach(Rails.root.join('db', "options#{year}.csv"), headers: true) do |row|
    option = Option.create!(
      question_id: row['question_id'],
      option_text: row['option_text']
    ) do |option|
      option.position = row['position']
    end
    option.update(position: row['position']) unless option.new_record?
  end
end

['2023', '2022', '2021'].each do |year|
  CSV.foreach(Rails.root.join('db', "question_correct_answers#{year}.csv"), headers: true) do |row|
    QuestionCorrectAnswer.create!(
      question_id: row['question_id'],
      correct_answer: row['correct_answer']
    )
  end
end

['2023', '2022', '2021'].each do |year|
  CSV.foreach(Rails.root.join('db', "image_questions#{year}.csv"), headers: true) do |row|
    ImageQuestion.create!(
      question_id: row['question_id'],
      image_url: row['image_url']
    )
  end
end