class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :url
      t.boolean :added_to_newsletter, default: false

      t.timestamps
    end
  end
end
