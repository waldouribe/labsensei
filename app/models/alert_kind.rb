class AlertKind < ActiveRecord::Base
  belongs_to :institution

  has_and_belongs_to_many :parameter_kinds

  has_many :alerts

  validates :institution, :name, :severity, presence: true

  def to_s
    name
  end
end
