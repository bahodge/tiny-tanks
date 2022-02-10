require "uuid/json"
require "base64"
require "./spec_helper.cr"
require "../src/token.cr"

describe Token do
  describe "constructor" do
    it "initializes the token with passed arguments" do
      token = Token.new(id: UUID.random, user_id: UUID.random, expires_at: Time.utc)
      token.should_not be_nil
      token.id.should be_a(UUID)
      token.user_id.should be_a(UUID)
      token.expires_at.should be_a(Time)
    end

    it "has defaults" do
      token = Token.new
      token.should_not be_nil
      token.id.should be_a(UUID)
      token.expires_at.should be_a(Time)
    end
  end

  describe "#encode" do
    it "returns a string" do
      token = Token.new
      token.encode.should be_a(String)
    end
  end

  describe "#is_valid?" do
    it "returns true when @expires_at is in the future and user_id is not nil" do
      token = Token.new user_id: UUID.random
      token.is_valid?.should eq(true)
    end

    it "returns false when @expires_at is in the past" do
      token = Token.new expires_at: Time.utc.shift days: -1
      token.is_valid?.should eq(false)
    end

    it "returns false when @user_id is nil" do
      token = Token.new user_id: nil
      token.is_valid?.should eq(false)
    end
  end

  describe "#to_json" do
    it "serializes to json string" do
      json = Token.new.to_json

      # Assert
      json.should be_a(String)
      token = Token.from_json(json)

      token.id.should be_a(UUID)
      token.expires_at.should be_a(Time)
    end

    it "serializes to json string" do
      json = Token.new(user_id: UUID.random).to_json

      # Assert
      json.should be_a(String)
      token = Token.from_json(json)

      token.id.should be_a(UUID)
      token.user_id.should be_a(UUID)
      token.expires_at.should be_a(Time)
    end
  end

  describe "#decode" do
    it "returns a string" do
      token = Token.new
      encoded = Base64.strict_encode("cookies")
      decoded = token.decode(encoded)

      decoded.should eq("cookies")
    end
  end

  describe ".decode" do
    it "returns a string" do
      encoded = Base64.strict_encode("cookies")
      decoded = Token.decode(encoded)

      decoded.should eq("cookies")
    end
  end

  describe ".from_json" do
    it "can be derrived from json" do
      json = Token.new.to_json

      result = Token.from_json json
      result.should be_a(Token)
    end
  end

  describe ".from_encoded" do
    it "returns a new token" do
      token = Token.new
      encoded_token = token.encode

      result = Token.from_encoded encoded_token
      result.should be_a(Token)
      result.id.should eq(token.id)
      result.expires_at.year.should eq(token.expires_at.year)
      result.expires_at.month.should eq(token.expires_at.month)
      result.expires_at.day.should eq(token.expires_at.day)
      result.expires_at.hour.should eq(token.expires_at.hour)
      result.expires_at.minute.should eq(token.expires_at.minute)
      result.expires_at.second.should eq(token.expires_at.second)
      result.expires_at.zone.should eq(token.expires_at.zone)
    end
  end
end
