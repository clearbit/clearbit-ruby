module Clearbit
  module Streaming
    class PersonCompany < Clearbit::PersonCompany
      endpoint 'https://person-stream.clearbit.com'
    end
  end
end