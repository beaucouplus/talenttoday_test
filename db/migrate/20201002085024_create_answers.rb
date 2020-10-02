class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :questionnaire_token
      t.string :chosen_dimension
      t.string :other_dimension
      t.integer :intensity

      t.timestamps
    end
  end
end
