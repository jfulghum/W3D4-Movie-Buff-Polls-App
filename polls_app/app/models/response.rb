class Response < ApplicationRecord
  validates :answer_choice_id, presence: true
  validates :responder_id, presence: true
  validate :already_answered
  validate :author_cheating

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    foreign_key: :responder_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    self.sibling_responses.each do |response|
      return true if response.responder_id == self.responder_id
    end
    false
  end

  def author_of_poll_cheating?
    self.responder_id == self.question.poll.author_id
  end


  private
  def already_answered
    if respondent_already_answered?
      errors[:respondent_already_answered?] << 'User has already responded!'
    end
  end

  def author_cheating
    if author_of_poll_cheating?
      errors[:authors_cheating] << 'Author may not rig the results!'
    end
  end

end
