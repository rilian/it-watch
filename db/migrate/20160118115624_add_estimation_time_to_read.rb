# frozen_string_literal: true
class AddEstimationTimeToRead < ActiveRecord::Migration
  def change
    add_column :links, :time_to_read, :string
  end
end
