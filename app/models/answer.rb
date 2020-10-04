class Answer < ApplicationRecord
  INTENSITY_TO_SCORE = { 1 => 1, 2 => 3 }.freeze

  DIMENSIONS = %w[AMBITION THOROUGHNESS PATIENCE EMPATHY].freeze

  validates :chosen_dimension, :other_dimension, :intensity, :questionnaire_token, presence: true
  validates :intensity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :chosen_dimension, :other_dimension, inclusion: { in: DIMENSIONS }

  def self.scores_for(questionnaire_token:)
    answers = where(questionnaire_token: questionnaire_token).to_a

    scores = {
      'AMBITION' => 0,
      'THOROUGHNESS' => 0,
      'PATIENCE' => 0,
      'EMPATHY' => 0
    }
    answers.each do |answer|
      score_value = INTENSITY_TO_SCORE[answer.intensity]
      scores[answer.chosen_dimension] += score_value
      scores[answer.other_dimension] -= score_value
      scores[answer.other_dimension] = 0 if scores[answer.other_dimension].negative?
    end
    scores
  end
end
