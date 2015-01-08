class CreateCustomFieldsExtensions < ActiveRecord::Migration
  def change
    create_table :custom_fields_extensions do |t|
      t.integer :custom_field_id, null: false
      t.integer :proposer_id
      t.string :comment
    end
    execute <<-SQL
      ALTER TABLE custom_fields_extensions
        ADD CONSTRAINT fk_custom_fields_extensions_custom_fields
        FOREIGN KEY (custom_field_id)
        REFERENCES custom_fields(id)
         on DELETE cascade
    SQL
  end
end
