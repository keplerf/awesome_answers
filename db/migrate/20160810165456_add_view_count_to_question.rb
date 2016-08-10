class AddViewCountToQuestion < ActiveRecord::Migration[5.0]

    def change
      add_column :questions, :view_count, :string
    end
end
