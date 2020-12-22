class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :answer
      t.references :question, null: false, foreign_key: true
      t.references :player, foreign_key: true
      t.integer :votes_count, default: 0

      t.timestamps
    end
  end
end
