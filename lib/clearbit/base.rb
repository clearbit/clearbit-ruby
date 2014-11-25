module Clearbit
  class Base < Resource
    endpoint 'https://api.clearbit.com'
    options :format => :json
  end
end
