class Recipe < ActiveRecord::Base
	has_many :ingredients
	has_many :directions
	accepts_nested_attributes_for :ingredients,
																reject_if: proc { |attributes|['name'.blank?] },
																allow_destroy: true
	accepts_nested_attributes_for :directions,
																reject_if: proc { |attributes|['step'.blank?] },
																allow_destroy: true															
  validates :title, :description, :image, presence: true
  has_attached_file :image, styles: { medium: "400x400#" }, default_url: "/images/medium/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

