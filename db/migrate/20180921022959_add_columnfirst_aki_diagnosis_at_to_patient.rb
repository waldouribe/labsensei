class AddColumnfirstAkiDiagnosisAtToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :first_aki_diagnosis_at, :datetime
  end
end
