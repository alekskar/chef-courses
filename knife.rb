# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "akaravai"
client_key               "#{current_dir}/akaravai.pem"
validation_client_name   "chef_1-validator"
validation_key           "#{current_dir}/4thcoffee-validator.pem"
chef_server_url          "https://chefserver/organizations/chef_1"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["#{current_dir}/cookbooks"]
