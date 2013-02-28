module ActiveRecord
  class Base

    def self.nql(query, options={})
      nql! query, options
    rescue NQL::Error
      self.where('1=2')
    end

    def self.nql!(query, options={})
      nql_search(query).result(options)
    end

    def self.nql_search(query)
      NQL::Query.new(self, query).ransack_search
    end

  end
end