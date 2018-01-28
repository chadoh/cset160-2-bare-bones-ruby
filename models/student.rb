require "active_record"
require "yaml"

db_config = YAML::load(File.open('db/database.yml'))

ActiveRecord::Base.establish_connection(db_config)

class Student < ActiveRecord::Base
end
