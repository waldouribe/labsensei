class Alert < ActiveRecord::Base
  belongs_to :patient
  belongs_to :alert_kind
  belongs_to :parameter

  def severity
    alert_kind.severity
  end
end
