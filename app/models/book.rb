# frozen_string_literal: true

class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :publisher

  before_validation :set_data

  scope :ordered, -> { order(created_at: :desc, title: :asc) }

  def self.search(params)
    records = Book.all
    records = records.where('title ILIKE ?', "#{params[:title]}%") if params[:title].present?
    records = records.where('publisher ILIKE ?', "#{params[:publisher]}%") if params[:publisher].present?
    records = records.where(isbn: params[:isbn]) if params[:isbn].present?
    records = records.where(published_date: params[:published_date]) if params[:published_date].present?
    records = records.where(quantity: params[:quantity]) if params[:quantity].present?
    records.distinct.ordered
  end

  private

  def set_data
    self.published_date = Time.now unless published_date.present?
    self.quantity = 0 unless quantity.present?
  end
end
