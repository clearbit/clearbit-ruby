module APIHub
  class Base < Resource
    endpoint 'https://api.apihub.co'
    options :format => :json
  end
end
