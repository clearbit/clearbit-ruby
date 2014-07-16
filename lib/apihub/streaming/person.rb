module APIHub
  module Streaming
    class Person < APIHub::Person
      endpoint 'https://person-stream.apihub.co'
    end
  end
end