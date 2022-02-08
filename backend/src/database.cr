require "./user.cr"

alias Record = User

class CollectionDoesNotExist < Exception
end

class Database
  getter :name, :collections

  def initialize(@name : String)
    @collections = [] of Collection(JSON::Any)
  end

  def create_collection(name, record_type : Record)
    p! record_type
    c = Collection(Record).new name
    @collections.push(c)
  end

  def get(collection_name : String)
    found_collection = @collections.find &.name == collection_name

    p! found_collection

    found_collection

    # if found_collection
    #   found_collection
    # else
    #   raise CollectionDoesNotExist.new "Collection #{collection_name} does not exist"
    # end
  end
end

class Collection(T)
  getter :name, :records

  def initialize(@name : String, record_type)
    @records = [] of typeof(record_type)
  end
end
