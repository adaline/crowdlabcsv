describe 'UserImporter' do
  context "importing data" do
    subject(:reader){ CsvReader.new("gender,name,email,password,born_on,extra\nfemale,Miss Natasha,natasha_raynor@nikolaus.org,8ptj9jiga,2013-06-25,Woot") }
    subject(:importer) { UserImporter.new(reader) }
    subject(:project){ FactoryGirl.create(:project) }
    subject(:sort_order){ [4, 0, 1, 2, 3, 5] }

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

    it "must connect to the correct project" do
      importer.import_data(project.id, sort_order)
      user = User.first
      expect(user.projects).to eq [project]
    end

    it "must save extra fields correctly" do
      importer.import_data(project.id, sort_order)
      membership = Membership.first
      expect(membership.attached_data).to eq 'extra' => 'Woot'
    end
  end
end
