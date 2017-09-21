# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Question.destroy_all
Poll.destroy_all
Response.destroy_all
AnswerChoice.destroy_all

alphabet = ("a".."z").to_a
name_array = alphabet.map { |c| "person_#{c}" }

name_array.each do |p_name|
  User.create!(username: p_name)
end

Poll.create!(title: 'The meaning of life', author_id: User.find_by(username: 'person_a').id)
Poll.create!(title: 'Politics today', author_id: User.find_by(username: 'person_b').id)
Poll.create!(title: 'Religiosity', author_id: User.find_by(username: 'person_c').id)

# Question.create!()
Question.create!(poll_id: Poll.first.id, text: "What do you find most meaningful?")
Question.create!(poll_id: Poll.last.id, text: "How religious are you?")
Question.create!(poll_id: Poll.last.id, text: "What religion are you?")


AnswerChoice.create!(question_id: Question.first.id, text: "True")
AnswerChoice.create!(question_id: Question.last.id, text: "True")
AnswerChoice.create!(question_id: Question.last.id, text: "False")
AnswerChoice.create!(question_id: Question.first.id, text: "False")

Response.create!(answer_choice_id: AnswerChoice.first.id, responder_id: User.find_by(username: 'person_c').id)
Response.create!(answer_choice_id: AnswerChoice.first.id, responder_id: User.find_by(username: 'person_b').id)
Response.create!(answer_choice_id: AnswerChoice.first.id, responder_id: User.find_by(username: 'person_g').id)
Response.create!(answer_choice_id: AnswerChoice.first.id, responder_id: User.last.id)

Response.create!(answer_choice_id: AnswerChoice.last.id, responder_id: User.find_by(username: 'person_y').id)
Response.create!(answer_choice_id: AnswerChoice.last.id, responder_id: User.find_by(username: 'person_d').id)
