class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title
      t.string :publisher
      t.string :isbn
      t.date :published_date

      t.timestamps
    end
  end
end
