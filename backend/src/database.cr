require "./user.cr"

class Database
  property collections : Hash(String, Collection)

  def initialize
    @collections = Hash(String, Collection).new

    p! "collections #{@collections}"
  end

  def create_collection(name : String)
  end
end

class Collection(T)
  property :records

  def initialize
    @records = [] of Record(T)

    p! "records #{@records}"
  end
end
