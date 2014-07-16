module APIHub
  module Streaming
    class Company < APIHub::Company
      endpoint 'https://company-stream.apihub.co'
    end
  end
end