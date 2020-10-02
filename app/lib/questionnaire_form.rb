class QuestionnaireForm
  include ActiveModel::Model

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

  def save
    answers.each do |key, answer|
      Answer.create!(chosen_dimension: answer,
                    other_dimension: other_dimension(key, answer),
                    intensity: 1,
                    questionnaire_token: token)
    end
    true
  end

  def other_dimension(key, answer)
    PAIRS[key.to_i].find { |dimension| dimension != answer }
  end
end
