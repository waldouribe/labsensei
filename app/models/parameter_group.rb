class ParameterGroup < ActiveRecord::Base
  belongs_to :parameter_group_kind
  belongs_to :patient

  has_many :parameters

  accepts_nested_attributes_for :parameters, allow_destroy: true, reject_if: lambda { |p| p[:raw_value].blank? or p[:parameter_kind_id].blank? }
end
