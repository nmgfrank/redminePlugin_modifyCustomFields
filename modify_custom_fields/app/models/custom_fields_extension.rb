class CustomFieldsExtension < ActiveRecord::Base
  unloadable
  
  belongs_to :custom_fields
  
  
end
