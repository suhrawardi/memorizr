class RenamePageToWebPage < ActiveRecord::Migration
  def up
    rename_table :pages, :web_pages
  end 
  def down
    rename_table :web_pages, :pages
  end
end
