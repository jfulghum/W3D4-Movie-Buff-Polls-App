# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  answer_choices :string           not null
#  poll_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#


class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses ,
    through: :answer_choices,
    source: :responses

  belongs_to :poll,
    foreign_key: :poll_id,
    class_name: :Poll

  def results
    results = Hash.new(0)
    self.answer_choices.each do |choice|
      results[choice.text] += choice.responses.length
    end
    results
  end


  def results_includes
    answers = self.answer_choices.includes(:responses)

    results = Hash.new(0)
    answers.each do |choice|
      results[choice.text] += choice.responses.length
    end
    results
  end

  def results_good
    results = Hash.new(0)

    answers = self.answer_choices.select('answer_choices.*, COUNT(responses.id) as count')
    .left_outer_joins(:responses)
    .group('answer_choices.id')

    answers.each do |choice|
      results[choice.text] += choice.count
    end
    results

  end



end
