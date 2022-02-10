require "./user.cr"

class RecordNotFound < Exception
end

class Database
  property collections : Hash(String, Collection)

  def initialize
    @collections = Hash(String, Collection).new
  end

  def create_collection(collection_name : String)
    @collections[collection_name] = Collection.new
  end
end

class Collection
  property :records

  def initialize
    @records = Hash(UUID, String).new
  end

  def insert(id : UUID, record : String)
    @records[id] = record
  end

  def find_by(id : UUID)
    if @records.has_key? id
      @records[id]
    else
      raise RecordNotFound.new "record with id: #{id} does not exist"
    end
  end
end
