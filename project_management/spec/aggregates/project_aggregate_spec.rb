require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'Project aggregate' do
    specify 'register new project' do
      project = ProjectManagement::Project.new(project_uuid)
      project.register(project_name)

      expect(project).to(have_applied(project_registered))
    end

    specify 'estimate the project' do
      project = ProjectManagement::Project.new(project_uuid)
      project.register(project_name)
      project.estimate(project_estimation)

      expect(project).to(have_applied(project_estimated))
    end

    specify 'assign deadline for the project' do
      project = ProjectManagement::Project.new(project_uuid)
      project.assign_deadline(project_deadline)

      expect(project).to(have_applied(deadline_assigned))
    end

    specify 'assigning deadline from the past is forbidden' do
      project          = ProjectManagement::Project.new(project_uuid)
      project_deadline = Time.current.yesterday.to_date.strftime('%d-%m-%Y')

      expect{ project.assign_deadline(project_deadline) }
        .to(raise_error(ProjectManagement::DeadlineFromPast))
    end

    specify 'assign developer to the project' do
      project = ProjectManagement::Project.new(project_uuid)
      project.assign_developer(developer_uuid, developer_fullname)

      expect(project).to(have_applied(developer_assigned))
    end

    specify 'assign developer working hours per week' do
      project = ProjectManagement::Project.new(project_uuid)
      project.assign_developer_working_hours(developer_uuid, developer_hours_per_week)

      expect(project).to(have_applied(developer_working_hours_assigned))
    end

    specify 'cannot assign more then 40 working hours per week' do
      project        = ProjectManagement::Project.new(project_uuid)
      hours_per_week = 50

      expect{ project.assign_developer_working_hours(developer_uuid, hours_per_week) }
        .to(raise_error(ProjectManagement::HoursPerWeekExceeded))
    end

    private

    def project_registered
      an_event(ProjectManagement::ProjectRegistered).with_data(project_data)
    end

    def project_estimated
      an_event(ProjectManagement::ProjectEstimated).with_data(estimate_data)
    end

    def developer_assigned
      an_event(ProjectManagement::DeveloperAssignedToProject).with_data(developer_assigned_data)
    end

    def deadline_assigned
      an_event(ProjectManagement::DeadlineAssignedToProject).with_data(deadline_assigned_data)
    end

    def developer_working_hours_assigned
      an_event(ProjectManagement::DeveloperWorkingHoursForProjectAssigned)
        .with_data(developer_working_hours_assigned_data)
    end

    def project_data
      {
        uuid: project_uuid,
        name: project_name
      }
    end

    def estimate_data
      {
        uuid:  project_uuid,
        hours: project_estimation
      }
    end

    def developer_assigned_data
      {
        project_uuid:       project_uuid,
        developer_uuid:     developer_uuid,
        developer_fullname: developer_fullname
      }
    end

    def deadline_assigned_data
      {
        uuid:     project_uuid,
        deadline: project_deadline
      }
    end

    def developer_working_hours_assigned_data
      {
        project_uuid:   project_uuid,
        developer_uuid: developer_uuid,
        hours_per_week: developer_hours_per_week
      }
    end

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def project_name
      'awesome_project'
    end

    def project_estimation
      40
    end

    def project_deadline
      Time.current.to_date.strftime('%d-%m-%Y')
    end

    def developer_uuid
      'cf14299b-b3b3-4b99-b511-6aa315cdad95'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end

    def developer_hours_per_week
      20
    end
  end
end