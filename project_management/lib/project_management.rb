module ProjectManagement
end

require_dependency 'project_management/commands/register_project.rb'
require_dependency 'project_management/commands/estimate_project.rb'
require_dependency 'project_management/commands/assign_developer_to_project.rb'
require_dependency 'project_management/commands/register_developer.rb'
require_dependency 'project_management/commands/assign_developer_working_hours.rb'
require_dependency 'project_management/commands/assign_deadline.rb'

require_dependency 'project_management/domain_events/project_registered.rb'
require_dependency 'project_management/domain_events/project_estimated.rb'
require_dependency 'project_management/domain_events/developer_registered.rb'
require_dependency 'project_management/domain_events/developer_assigned_to_project.rb'
require_dependency 'project_management/domain_events/deadline_assigned_to_project.rb'
require_dependency 'project_management/domain_events/developer_working_hours_for_project_assigned.rb'

require_dependency 'project_management/aggregates/developer.rb'
require_dependency 'project_management/aggregates/project.rb'

require_dependency 'project_management/command_handlers/developers_command_handler.rb'
require_dependency 'project_management/command_handlers/projects_command_handler.rb'

require_dependency 'project_management/process_managers/project_kickoff.rb'

require_dependency 'project_management/read_models/developer_list/builder'
require_dependency 'project_management/read_models/developer_list/retriever'
require_dependency 'project_management/read_models/developer_list/state'

require_dependency 'project_management/value_objects/deadline'
