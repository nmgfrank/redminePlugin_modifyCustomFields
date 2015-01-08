require_dependency 'issues_controller'

module ModifyCustomFields
    module IssuesControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                skip_before_filter :authorize, :only => [:modify_custom_fields_append_proposer,:modify_custom_fields_proposer_new,:modify_custom_fields_autocomplete_for_proposer]

                
            end
        end

        module InstanceMethods
            def modify_custom_fields_append_proposer
                if !params['proposer_id'].nil?
                    @proposer_id = params['proposer_id']
                else
                    @proposer_id = nil
                end
                render :layout => false
            end

            def modify_custom_fields_proposer_new
                render :template => "modify_custom_fields/users_searchbox"
            end

            def modify_custom_fields_autocomplete_for_proposer
                @users = User.active.sorted.like(params[:q]).all
                
                render :layout => false
            end
        end


    end
end
IssuesController.send(:include, ModifyCustomFields::IssuesControllerPatch)
