json.extract! borrow_book, :id, :user_id, :book_id, :issue_date, :return_date, :fine, :created_at, :updated_at
json.url borrow_book_url(borrow_book, format: :json)
