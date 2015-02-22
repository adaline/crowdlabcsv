class UsersController < ApplicationController
  before_filter :fetch_project

  def index
    @users = @project.users
  end

  def verify_import
    # for this example's convinience only
    # not a realistic way to handle uplaods of course!
    session[:upload_data] = params[:file].read

    @header = CsvImporter.new(session[:upload_data]).header
    @fields = CsvImporter.expected_fields_in_order
  end

  def process_import
    importer = CsvImporter.new(session[:upload_data])
    mapping = params[:field_mapping]

    # Sort mapping by the csv header
    csv_header = importer.header
    sort_order = csv_header.map {|field| mapping[field].to_i }

    importer.import_data(@project.id, sort_order)

    redirect_to project_users_path(@project), notice: 'Users imported from CSV'
  end

  private

  def fetch_project
    @project = Project.find(params[:project_id])
  end
end
