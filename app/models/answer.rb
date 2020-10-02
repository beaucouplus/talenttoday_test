class Answer < ApplicationRecord
  def self.scores_for(questionnaire_token:)
    { 'AMBITION': 0,
      'THOROUGHNESS': 0 }
  end
end
