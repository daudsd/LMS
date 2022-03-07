class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :publisher

  before_validation :set_published_date, unless: -> { published_date.present? }

  scope :ordered, -> { order(:created_at, :title) }

  def self.search(params)
    books = Book.all
    books = Book.where('title ILIKE ?', "#{params[:title]}%") if params[:title].present?
    books = Book.where('publisher ILIKE ?', "#{params[:publisher]}%") if params[:publisher].present?
    books = Book.where(isbn: params[:isbn]) if params[:isbn].present?
    books = Book.where(published_date: params[:published_date]) if params[:published_date].present?
    books.distinct.ordered
  end

  private

  def set_published_date
    self.published_date = Time.now
  end
end
