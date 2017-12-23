require "graphql2csv"

RSpec.describe GraphQL2CSV do
    it "sums the prices of its line items" do
      graphql2csv = GraphQL2CSV.new
  
      graphql2cs.add_entry(LineItem.new(:item => Item.new(
        :price => Money.new(1.11, :USD)
      )))
      graphql2cs.add_entry(LineItem.new(:item => Item.new(
        :price => Money.new(2.22, :USD),
        :quantity => 2
      )))
  
      expect(graphql2cs.total).to eq(Money.new(5.55, :USD))
    end
  end