require "json"
require "./spec_helper"
require "../src/collection.cr"

describe Collection do
  # TODO: Write tests

  it "constructor" do
    collection = Collection.new("my_collection")

    collection.name.should eq "my_collection"
  end

  describe "#insert" do
    it "takes a Hash" do
      collection = Collection.new("my_collection")

      result = collection.insert(record: {"my_record" => "my_value"})
      result.size.should eq(1)
    end
    it "raises if record already exists" do
      collection = Collection.new("my_collection")

      collection.insert(record: {"id" => 1})
      collection.data.size.should eq(1)

      begin
        collection.insert(record: {"id" => 1})
      rescue msg : RecordAlreadyExists
        msg.should eq("record with id `1` already exists")
      end
    end
  end
end
