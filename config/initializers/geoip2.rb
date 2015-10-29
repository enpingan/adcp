require 'geoip2'

Geoip2.configure do |conf|
  conf.license_key = '0bw5zNYQtUa8'
  conf.user_id = '102671'

  conf.host = 'geoip.maxmind.com' 
  conf.base_path = '/geoip/v2.1'
  conf.parallel_requests = 5
end