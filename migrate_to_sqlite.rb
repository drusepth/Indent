require 'json'

def load_objects(klass, json_source_file)
  File.open(json_source_file, "r").each_line do |line|

    # Sanitize mongo associations
    line.gsub!(/ObjectId\( "([^\)]+)" \)/, ' "\1"')

    # Remove mongo dates
    line.gsub!(/Date\( [\d]+ \)/, '""')

    # Create instance in memory
    memory_object = klass.new

    # Assign properties to instance
    json_object = JSON.parse line
    json_object.keys.each do |key|
      memory_object[key] = json_object[key]
    end

    # Save to DB
    #memory_object.save!
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
