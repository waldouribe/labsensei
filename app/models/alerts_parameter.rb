class AlertsParameter < ActiveRecord::Base
  belongs_to :alert
  belongs_to :parameter
end
