module Clearbit
  class Base < Resource
    endpoint 'https://api.clearbit.co'
    options :format => :json
  end
end
