class DropAcFromQuestionAndAddText < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :answer_choices
    add_column :questions, :text, :string, null: false
  end
end
