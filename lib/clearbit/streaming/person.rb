module Clearbit
  module Streaming
    class Person < Clearbit::Person
      endpoint 'https://person-stream.clearbit.co'
    end
  end
end