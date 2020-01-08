source 'https://supermarket.getchef.com'
metadata

group :integration do
  cookbook 'apt'
  cookbook 'build-essential'
  cookbook 'faraday-lwrp', path: 'test/cookbooks/faraday-lwrp'
  cookbook 'couchdb', git: 'https://github.com/wohali/couchdb-cookbook', ref: 'd7a2448a' # Fix resource...
end
