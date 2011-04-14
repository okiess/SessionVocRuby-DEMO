# A demo model class.
class Address < ActiveRecord::Base
  attr_accessor :nonce, :fid, :firstname, :lastname, :street, :housenumber, :zipcode, :city
  
  def self.columns
    @columns ||= [];
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default,
      sql_type.to_s, null)
  end

  def save(validate = true)
    true
  end

  def to_hash
    address = {}
    address['firstname'] = self.firstname if self.firstname
    address['lastname'] = self.lastname if self.lastname
    address['street'] = self.street if self.street
    address['housenumber'] = self.housenumber if self.housenumber
    address['zipcode'] = self.zipcode if self.zipcode
    address['city'] = self.city if self.city
    address
  end
end
