class CreatePagesYetAgain < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :link
      t.string :parameter
      t.text :body
      t.timestamps
    end
  end
end
