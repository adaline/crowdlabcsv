require 'rails_helper'

describe "CsvImporter" do
  context "basic CSV parsing" do
    subject(:importer){ CsvImporter.new("name,email,password\nJohn Doe,john@example.com,root") }

    it "must parse the header correctly" do
      expect(importer.header).to eq(['name', 'email', 'password'])
    end

    it "must parse the data correctly" do
      expect(importer.data.first).to eq(['John Doe', 'john@example.com', 'root'])
    end
  end

  context "importing data" do
    subject(:importer){ CsvImporter.new("gender,name,email,password,born_on\nfemale,Miss Natasha,natasha_raynor@nikolaus.org,8ptj9jiga,2013-06-25") }
    subject(:project){ FactoryGirl.create(:project) }
    subject(:sort_order){ [4, 0, 1, 2, 3] }

    it "must import the record in" do
      expect{importer.import_data(project.id, sort_order)}.to change {User.count}.by(1)
    end

    it "must map fields correctly" do
      importer.import_data(project.id, sort_order)
      user = User.first
      expect(user.name).to eq 'Miss Natasha'
      expect(user.email).to eq 'natasha_raynor@nikolaus.org'
      expect(user.gender).to eq 'f'
      expect(user.password).to eq '8ptj9jiga'
      expect(user.born_on).to eq Date.parse('2013-06-25')
    end
  end
end
