require "application_system_test_case"

class BorrowBooksTest < ApplicationSystemTestCase
  setup do
    @borrow_book = borrow_books(:one)
  end

  test "visiting the index" do
    visit borrow_books_url
    assert_selector "h1", text: "Borrow books"
  end

  test "should create borrow book" do
    visit borrow_books_url
    click_on "New borrow book"

    fill_in "Book", with: @borrow_book.book_id
    fill_in "Fine", with: @borrow_book.fine
    fill_in "Issue date", with: @borrow_book.issue_date
    fill_in "Return date", with: @borrow_book.return_date
    fill_in "User", with: @borrow_book.user_id
    click_on "Create Borrow book"

    assert_text "Borrow book was successfully created"
    click_on "Back"
  end

  test "should update Borrow book" do
    visit borrow_book_url(@borrow_book)
    click_on "Edit this borrow book", match: :first

    fill_in "Book", with: @borrow_book.book_id
    fill_in "Fine", with: @borrow_book.fine
    fill_in "Issue date", with: @borrow_book.issue_date
    fill_in "Return date", with: @borrow_book.return_date
    fill_in "User", with: @borrow_book.user_id
    click_on "Update Borrow book"

    assert_text "Borrow book was successfully updated"
    click_on "Back"
  end

  test "should destroy Borrow book" do
    visit borrow_book_url(@borrow_book)
    click_on "Destroy this borrow book", match: :first

    assert_text "Borrow book was successfully destroyed"
  end
end
