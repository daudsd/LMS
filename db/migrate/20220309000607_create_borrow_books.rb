class CreateBorrowBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :borrow_books, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :book, type: :uuid
      t.date :issue_date
      t.date :return_date
      t.decimal :fine

      t.timestamps
    end
  end
end
