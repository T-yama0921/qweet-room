class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :tweets, :nickname, :string
    add_column    :tweets, :question,            :text,   null: false
    add_column    :tweets, :answer,              :string, null: false, default: ""
    add_column    :tweets, :first_incorrection,  :string, null: false, default: ""
    add_column    :tweets, :second_incorrection, :string, null: false, default: ""
    add_column    :tweets, :answer_feedback,     :text
    add_column    :tweets, :first_feedback,      :text
    add_column    :tweets, :second_feedback,     :text
    add_reference :tweets, :user,                         null: false, foreign_key: true
  end
end
