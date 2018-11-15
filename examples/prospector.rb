require 'clearbit'

response = Clearbit::Prospector.search(domain: 'clearbit.com', page: 1)

puts "Displaying #{response[:results].size} of #{response[:total]} results:"

response[:results].each_with_index do |person, index|
  puts "  #{index + 1}. #{person.name.full_name} (#{person.email})"
end
