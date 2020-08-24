module Arel
  module Visitors
    class ToSql
      alias :visit_Integer :literal
    end
  end
end