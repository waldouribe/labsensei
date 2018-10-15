class AlertKindsParameterKind < ActiveRecord::Base
  belongs_to :alert_kind
  belongs_to :parameter_kind
end
