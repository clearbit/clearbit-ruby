require 'clearbit'
require 'pp'

pp Clearbit::Discovery.search(tech: 'marketo')
