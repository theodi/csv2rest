require 'spec_helper'

describe Csv2rest do
  it 'has a version number' do
    expect(Csv2rest::VERSION).not_to be nil
  end

  it 'turns a simple CSV into simple JSON' do
    
    @csv = "file://" + File.join(File.dirname(__FILE__), "fixtures", "tomato-types.csv")
    @schema = Csvlint::Schema.load_from_json(File.join(File.dirname(__FILE__), "fixtures", "tomato-types.csv-metadata.json"))
    
    g = Csv2rest.generate @csv, @schema
    
    expect(g['/tomato-types/cordon']).to eq (
      {
        "type" => "cordon",
        "also called" => "indeterminate",
        "description" => "grows very tall"
      }
    )

    expect(g['/tomato-types/bush']).to eq (
      {
        "type" => "bush",
        "also called" => "determinate",
        "description" => "does not require pruning"
      }
    )
  end
end
