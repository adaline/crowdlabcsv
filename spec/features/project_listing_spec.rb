require 'rails_helper'

describe "View projects" do
  it "shows projects" do
    project = FactoryGirl.create(:project)
    visit '/'
    expect(page).to have_content project.name
  end

  it "lets you view project's users" do
    project = FactoryGirl.create(:project)
    visit '/'
    expect(page).to have_link project.name

    click_link project.name
    expect(page).to have_content "Users for project #{project.name}"
  end

end
