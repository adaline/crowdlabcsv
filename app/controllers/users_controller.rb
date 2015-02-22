class UsersController < ApplicationController
  before_filter :fetch_project

  def index
    @users = @project.users
  end

  def verify_import
    # for this example's convinience only
    # not a realistic way to handle uplaods of course!
    session[:upload_data] = params[:file].read

    @header = CsvReader.new(session[:upload_data]).header
    @fields = UserImporter.expected_fields_in_order
  end

  def process_import
    reader = CsvReader.new(session[:upload_data])

    # Sort mapping by the csv header
    sort_order = reader.header.map {|field| params[:field_mapping][field].to_i }

    # Import data
    importer = UserImporter.new(reader).import_data(@project.id, sort_order)

    redirect_to project_users_path(@project), notice: 'Users imported from CSV'
  end

  private

  def fetch_project
    @project = Project.find(params[:project_id])
  end
end
