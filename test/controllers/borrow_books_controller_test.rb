require "test_helper"

class BorrowBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @borrow_book = borrow_books(:one)
  end

  test "should get index" do
    get borrow_books_url
    assert_response :success
  end

  test "should get new" do
    get new_borrow_book_url
    assert_response :success
  end

  test "should create borrow_book" do
    assert_difference("BorrowBook.count") do
      post borrow_books_url, params: { borrow_book: { book_id: @borrow_book.book_id, fine: @borrow_book.fine, issue_date: @borrow_book.issue_date, return_date: @borrow_book.return_date, user_id: @borrow_book.user_id } }
    end

    assert_redirected_to borrow_book_url(BorrowBook.last)
  end

  test "should show borrow_book" do
    get borrow_book_url(@borrow_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_borrow_book_url(@borrow_book)
    assert_response :success
  end

  test "should update borrow_book" do
    patch borrow_book_url(@borrow_book), params: { borrow_book: { book_id: @borrow_book.book_id, fine: @borrow_book.fine, issue_date: @borrow_book.issue_date, return_date: @borrow_book.return_date, user_id: @borrow_book.user_id } }
    assert_redirected_to borrow_book_url(@borrow_book)
  end

  test "should destroy borrow_book" do
    assert_difference("BorrowBook.count", -1) do
      delete borrow_book_url(@borrow_book)
    end

    assert_redirected_to borrow_books_url
  end
end
