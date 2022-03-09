class UpdateBorrowBook < ActiveRecord::Migration[7.0]
  def change
    add_column :borrow_books, :is_returned, :boolean, default: false
  end
end
