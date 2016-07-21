class AddTrialIdToVolunteers < ActiveRecord::Migration[5.0]
  def change
    add_reference :volunteers, :trial, foreign_key: true
  end
end
