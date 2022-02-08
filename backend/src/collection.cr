require "json"

# type Record = Hash(String, String) | Hash(String, Int32)

class RecordAlreadyExists < Exception
end

struct Record
end

class Collection
  getter :name, :data
  setter :name

  def initialize(@name : String)
    @data = [] of Hash(String, String) | Hash(String, Int32)
  end

  def insert(record)
    unless record.has_key? "id"
      record["id"] = "123" # generate a random id
    else
      found_record = @data.find { |r| r["id"] == record["id"] }
      if found_record
        raise RecordAlreadyExists.new "record with id `#{record["id"]}` already exists"
      end
    end

    @data.push(record)
  end

  def delete(id : UUID)
  end
end
