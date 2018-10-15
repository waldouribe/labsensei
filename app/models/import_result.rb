class ImportResult < ActiveRecord::Base
  belongs_to :import
  belongs_to :patient
  belongs_to :creatinine_test

  has_many :columns, dependent: :destroy
  accepts_nested_attributes_for :columns
end
