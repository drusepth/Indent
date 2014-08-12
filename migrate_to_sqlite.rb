require 'json'

def load_objects(klass, json_source_file)
  File.open(json_source_file, "r").each_line do |line|

    puts "--------------------------------"
    puts line

    # Sanitize mongo associations
    line.gsub!(/ObjectId\( "([^\)]+)" \)/, ' "\1"')

    # Remove mongo dates
    line.gsub!(/Date\( [\d]+ \)/, '""')

    puts line

    # Create instance in memory
    obj = klass.new

    # Assign properties to instance
    properties = JSON.parse line

    puts properties.inspect
  end
end

def path_for(klass)
  "/home/ubuntu/dump/app10401744/#{klass}.json"
end

classes_to_migrate = %w(users characters equipment languages locations magics universes)

db = {}
classes_to_migrate.each do |klass|
  db[klass] = load_objects(klass.singularize.titleize.constantize, path_for(klass))
end
