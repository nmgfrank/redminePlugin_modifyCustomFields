require 'redmine'

require_dependency 'modify_custom_fields/custom_fields_controller_patch' 
require_dependency 'modify_custom_fields/issues_controller_patch'


Redmine::Plugin.register :modify_custom_fields do
  name 'Modify Custom Fields'
  author 'nmgfrank'
  description 'It modifies the page that manages custom fields. It adds several funtions. 1. show info about trackers that custom field belongs to; 2. show the projects those custom fields are used; 3. make it easier to order the custom fields.'
  version '0.0.1'
  url 'http://nmgfrankblog.sinaapp.com'
  author_url 'http://nmgfrankblog.sinaapp.com'
end
