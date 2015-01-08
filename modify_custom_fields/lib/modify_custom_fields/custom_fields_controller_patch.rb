require_dependency 'custom_fields_controller'


module ModifyCustomFields
    module CustomFieldsControllerPatch
        def self.included(base)
            base.send(:include, InstanceMethods)
            base.class_eval do 
                            
            end
        end

        module InstanceMethods
        
            def modify_new
                build_new_custom_field
                @selected_tracker_id = params['tracker_id'].blank? ? "" : params['tracker_id'].to_s
            end

            def modify_create
                build_new_custom_field
                selected_tracker_id = params['tracker_id'].blank? ? "" : params['tracker_id'].to_s
                
                if @custom_field.save
                  flash[:notice] = l(:notice_successful_create)
                  call_hook(:controller_custom_fields_new_after_save, :params => params, :custom_field => @custom_field)
                  redirect_to "/custom_fields?tab=#{@custom_field.class.name}&tracker_id=#{selected_tracker_id}"
                else
                  render :action => 'modify_new'
                end
            end        
                
        
        
            def modify_edit
                find_custom_field
                extension_infos = CustomFieldsExtension.where(["custom_field_id = ?",params[:id]])
                
                @users = User.order("lastname").select {|u| u.active? }
                
                @extension_info = extension_infos.blank? ? nil : extension_infos[0]
               
            end
           
           
            def modify_update
                find_custom_field
                
                selected_tracker_id = params['tracker_id'].blank? ? "" : params['tracker_id'].to_s
                
                if !params[:extension].blank?
                    
                    extension_infos = CustomFieldsExtension.where(["custom_field_id = ?",params[:id]])
                    extension_info = extension_infos.blank? ? CustomFieldsExtension.new : extension_infos[0]           
                    extension_info.update_attributes(params[:extension])
                end
                if @custom_field.update_attributes(params[:custom_field])
                  flash[:notice] = l(:notice_successful_update)
                  call_hook(:controller_custom_fields_edit_after_save, :params => params, :custom_field => @custom_field)
                  redirect_to custom_fields_path(:tab => @custom_field.class.name) + "&tracker_id=#{selected_tracker_id}"
                else
                  render :action => 'modify_edit'
                end                
                
               
            end
 
             def modify_reorder
                find_custom_field
                
                selected_tracker_id = params['tracker_id'].blank? ? "" : params['tracker_id'].to_s
                
                result = false
                
                if params[:custom_field][:move_to] == "higher" && !selected_tracker_id.blank?
                    is_hit = false
                    while !is_hit do
                        if @custom_field.first?
                            is_hit = true
                        elsif @custom_field.higher_item.first?
                            is_hit = true
                            result = @custom_field.update_attributes(params[:custom_field])
                        else
                            @custom_field.higher_item.trackers.each do |tracker|
                                if tracker.id.to_s == selected_tracker_id
                                    is_hit = true
                                end
                            end 
                            result = @custom_field.update_attributes(params[:custom_field])                       
                        end
                    end
                elsif params[:custom_field][:move_to] == "lower" && !selected_tracker_id.blank?
                    is_hit = false
                    while !is_hit do
                        if @custom_field.last?
                            is_hit = true
                        elsif @custom_field.lower_item.first?
                            is_hit = true
                            result = @custom_field.update_attributes(params[:custom_field])
                        else
                            @custom_field.lower_item.trackers.each do |tracker|
                                if tracker.id.to_s == selected_tracker_id
                                    is_hit = true
                                end
                            end 
                            result = @custom_field.update_attributes(params[:custom_field])                       
                        end
                    end
                    
                else
                    result = @custom_field.update_attributes(params[:custom_field])                       
                end
                
                if result
                  flash[:notice] = l(:notice_successful_update)
                  call_hook(:controller_custom_fields_edit_after_save, :params => params, :custom_field => @custom_field)
                  redirect_to custom_fields_path(:tab => @custom_field.class.name) + "&tracker_id=#{selected_tracker_id}"
                else
                    flash[:notice] = "Fails while reorder"
                    redirect_to custom_fields_path(:tab => @custom_field.class.name) + "&tracker_id=#{selected_tracker_id}"
                end                
                
               
            end
 
 
            
            def modify_destroy
                find_custom_field
                selected_tracker_id = params['tracker_id'].blank? ? "" : params['tracker_id'].to_s
                
                begin
                  @custom_field.destroy
                rescue
                  flash[:error] = l(:error_can_not_delete_custom_field)
                end
                redirect_to custom_fields_path(:tab => @custom_field.class.name) + "&tracker_id=#{selected_tracker_id}"
            end




            
        end
    end
end

CustomFieldsController.send(:include, ModifyCustomFields::CustomFieldsControllerPatch)
