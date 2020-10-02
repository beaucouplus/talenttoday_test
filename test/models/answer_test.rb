require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test 'can compute scores' do
    questionnaire_token = 'abcde'

    Answer.create(
      chosen_dimension: 'AMBITION',
      other_dimension: 'THOROUGHNESS',
      intensity: 2,
      questionnaire_token: questionnaire_token
    )

    scores = Answer.scores_for questionnaire_token: questionnaire_token
    assert_equal 3, scores['AMBITION']
    assert_equal 0, scores['THOROUGHNESS']

    Answer.create(
      chosen_dimension: 'PATIENCE',
      other_dimension: 'AMBITION',
      intensity: 1,
      questionnaire_token: questionnaire_token
    )

    scores = Answer.scores_for questionnaire_token: questionnaire_token
    assert_equal 2, scores['AMBITION']
    assert_equal 1, scores['PATIENCE']
    assert_equal 0, scores['THOROUGHNESS']

    Answer.create(
      chosen_dimension: 'THOROUGHNESS',
      other_dimension: 'EMPATHY',
      intensity: 2,
      questionnaire_token: questionnaire_token
    )

    scores = Answer.scores_for questionnaire_token: questionnaire_token
    assert_equal 3, scores['THOROUGHNESS']
    assert_equal 2, scores['AMBITION']
    assert_equal 1, scores['PATIENCE']
    assert_equal 0, scores['EMPATHY']

    Answer.create(
      chosen_dimension: 'AMBITION',
      other_dimension: 'EMPATHY',
      intensity: 1,
      questionnaire_token: questionnaire_token
    )

    scores = Answer.scores_for questionnaire_token: questionnaire_token
    assert_equal 3, scores['THOROUGHNESS']
    assert_equal 3, scores['AMBITION']
    assert_equal 1, scores['PATIENCE']
    assert_equal 0, scores['EMPATHY']
  end
end
