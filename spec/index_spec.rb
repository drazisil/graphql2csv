require "graphql2csv"

RSpec.describe GraphQL2CSV do

    it "read the config.jspn file" do
      config = GraphQL2CSV.new.read_config('config_example.json')
      expect(config['token']).to eq("xxx")
    end
  end