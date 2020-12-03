class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  mount_uploader :image, ImageUploader
  serialize :image , JSON
  belongs_to :user, optional: true
  has_many :line_items


  validates :title, :brand ,:price , presence:true
  validates :description , length: {maximum: 1000, too_long: "description is too long"}
  validates :title , length: {maximum: 130, too_long: "description is too long"}
  validates :price , length:{maximum: 7}


  CONDITION = %w{NEW USED }

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line Items Present")
      throw :abort
    end
  end


end
