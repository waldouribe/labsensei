class ParameterKind < ActiveRecord::Base
  cattr_reader :TYPES
  @@TYPES = ['decimal', 'integer', 'boolean', 'string']

  belongs_to :parameter_group_kind

  has_and_belongs_to_many :alert_kinds
  
  has_many :triggers, dependent: :destroy
  has_many :alerts, through: :alert_kinds
  has_many :parameters, dependent: :destroy


  validates_inclusion_of :parameter_type, :in => @@TYPES
  validates :name, presence: true

  def to_s
    name
  end
end
