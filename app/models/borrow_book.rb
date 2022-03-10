# frozen_string_literal: true

class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # validates_uniqueness_of :book_id, scope: :user_id, message: " is already taken"
  
  validate :previous_record, if: -> { new_record? }
  validate :available_quantity, if: -> { new_record? }

  after_validation :set_dates, if: -> { new_record? }
  after_validation :update_book_quantity, unless: -> { new_record? }

  scope :ordered, -> { order(issue_date: :desc) }

  def self.admin_search(params)
    records = BorrowBook.eager_load(:user, :book).where(is_returned: false).all
    records = records.where('users.name ILIKE ?', "#{params[:name]}%") if params[:name].present?
    records = records.where('users.email ILIKE ?', "#{params[:email]}%") if params[:email].present?
    records = records.where('books.title ILIKE ?', "#{params[:title]}%") if params[:title].present?
    records = records.where(issue_date: params[:issue_date]) if params[:issue_date].present?
    records = records.where(return_date: params[:return_date]) if params[:return_date].present?
    records.distinct.ordered
  end

  def self.student_search(params)
    records = BorrowBook.eager_load(:book).where(is_returned: false).where(user_id: current_user&.id).all
    records = records.where('books.title ILIKE ?', "#{params[:title]}%") if params[:title].present?
    records = records.where(issue_date: params[:issue_date]) if params[:issue_date].present?
    records = records.where(return_date: params[:return_date]) if params[:return_date].present?
    records.distinct.ordered
  end

  private

  def previous_record
    bk = BorrowBook.where(user_id: self.user_id, book_id: self.book_id).order(created_at: :desc).first
    if bk.present? && !bk.is_returned
      errors.add(:book, 'Book is already issued, please return the previous book')
    end
  end

  def available_quantity
    book_quantity = book&.quantity.to_i
    if book_quantity > 0
      book.update(quantity: book_quantity - 1)
    else
      errors.add(:book, 'Books is not available')
    end
  end

  def set_dates
    self.issue_date = Time.now
    # self.return_date = Time.now.to_date + 15 # 15 days by default
    self.is_returned = false
  end

  def update_book_quantity
    if current_user.admin?
      self.is_returned = true
      self.return_date = Time.now.to_date
      book.update_attribute(:quantity, book.quantity + 1)
    else
      errors.add(:book, 'Access Denied')
    end
  end
end
