# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match '/custom_fields/:id/modify_edit', :to => 'custom_fields#modify_edit', :via => [:get, :post]

match '/custom_fields/:id/modify_update', :to => 'custom_fields#modify_update', :via => [:put]
match '/custom_fields/:id/modify_reorder', :to => 'custom_fields#modify_reorder', :via => [:put]

match '/custom_fields/modify_new', :to => 'custom_fields#modify_new', :via => [:get, :post]

match '/custom_fields/modify_create', :to => 'custom_fields#modify_create', :via => [:post]

match '/modify_custom_fields/proposer_new', :to => 'issues#modify_custom_fields_proposer_new', :via => [:get, :post]

match '/modify_custom_fields/modify_custom_fields_append_proposer', :to => 'issues#modify_custom_fields_append_proposer', :via => [:get, :post]

match '/modify_custom_fields/modify_custom_fields_autocomplete_for_proposer', :to => 'issues#modify_custom_fields_autocomplete_for_proposer', :via => [:get, :post]

match '/custom_fields/:id/modify_destroy', :to => 'custom_fields#modify_destroy', :via => [:delete]


