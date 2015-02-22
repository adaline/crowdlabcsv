require 'rails_helper'

describe "CsvReader" do
  subject(:reader){ CsvReader.new("name,email,password\nJohn Doe,john@example.com,root") }

  it "must parse the header correctly" do
    expect(reader.header).to eq(['name', 'email', 'password'])
  end

  it "must parse the data correctly" do
    expect(reader.data.first).to eq(['John Doe', 'john@example.com', 'root'])
  end
end
