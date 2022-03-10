# frozen_string_literal: true

class BorrowBooksController < ApplicationController
  before_action :set_borrow_book, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /borrow_books or /borrow_books.json
  def index
    if current_user.admin?
      @pagy, @records = pagy(BorrowBook.admin_search(params))
    else
      @pagy, @records = pagy(BorrowBook.student_search(params))
    end
  end

  # GET /borrow_books/1 or /borrow_books/1.json
  def show
  end

  # GET /borrow_books/new
  def new
    @borrow_book = BorrowBook.new
  end

  # GET /borrow_books/1/edit
  def edit
  end

  # POST /borrow_books or /borrow_books.json
  def create
    @borrow_book = BorrowBook.new
    @borrow_book.book_id = params.require(:book_id)
    @borrow_book.user_id = current_user.admin? ? params.require(:user_id) : current_user.id

    respond_to do |format|
      if @borrow_book.save
        format.html { redirect_to borrow_book_url(@borrow_book), notice: "Borrow book was successfully created." }
        format.json { render :show, status: :created, location: @borrow_book }
        format.js { render :show }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @borrow_book.errors, status: :unprocessable_entity }
        format.js { render :show }
      end
    end
  end

  # PATCH/PUT /borrow_books/1 or /borrow_books/1.json
  def update
    respond_to do |format|
      if @borrow_book.update(borrow_book_params)
        format.html { redirect_to borrow_book_url(@borrow_book), notice: "Borrow book was successfully updated." }
        format.json { render :show, status: :ok, location: @borrow_book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @borrow_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrow_books/1 or /borrow_books/1.json
  def destroy
    @borrow_book.destroy

    respond_to do |format|
      format.html { redirect_to borrow_books_url, notice: "Borrow book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_borrow_book
    @borrow_book = BorrowBook.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def borrow_book_params
    params.require(:borrow_book).permit(:id)
  end

end
