class QuestionnaireForm
  include ActiveModel::Model

  validate :answers_must_all_be_provided
  validate :answers_must_be_valid
  validate :must_have_token

  PAIRS = [
    %w[AMBITION THOROUGHNESS],
    %w[AMBITION PATIENCE],
    %w[EMPATHY THOROUGHNESS],
    %w[AMBITION EMPATHY],
    %w[THOROUGHNESS PATIENCE],
    %w[EMPATHY PATIENCE]
  ].freeze

  attr_accessor :token, :answers

  def questions
    PAIRS
  end

  def answers_to_record
    answers.map do |key, answer|
      Answer.new(chosen_dimension: answer,
                 other_dimension: other_dimension(key, answer),
                 intensity: 1,
                 questionnaire_token: token)
    end
  end

  def save
    return false unless valid?
    Answer.create(answers_to_record.map(&:attributes))
    true
  end

  private

  def other_dimension(key, answer)
    PAIRS[key.to_i].find { |dimension| dimension != answer }
  end

  def answers_must_all_be_provided
    errors.add(:answers_size, 'must be 6') if answers.size < 6
  end

  def answers_must_be_valid
    errors.add(:valid_answers, 'must be provided') if answers_to_record.any? { |answer| !answer.valid? }
  end

  def must_have_token
    errors.add(:token, 'must be provided') unless token
  end
end
