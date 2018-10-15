class ParameterGroupKind < ActiveRecord::Base
  belongs_to :institution
  has_many :parameter_kinds, dependent: :destroy

  accepts_nested_attributes_for :parameter_kinds, reject_if: :all_blank, allow_destroy: true

  def to_s
    name
  end
end
