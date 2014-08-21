require 'json'

def load_objects(klass, json_source_file)
  objects = []

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
      key = (key == '_id' ? 'id' : key)
      memory_object[key] = json_object[key]
    end

    # Save object into DB
    memory_object.save!

    puts "Translation: #{json_object['_id']} --> #{memory_object.id}"

    # Store object in memory to create links later
    objects << memory_object
  end

  objects
end

def update_links(id_translation_table, objects)
  objects.each do |object|
    object.attributes.each do |attr_name, attr_value|
      if attr_name.ends_with? '_id'
        puts "attr_name is #{attr_name}"
        puts "value is #{attr_value}"
        puts "Linking #{attr_name} to id #{id_translation_table[object.id]} for id #{object.id}"
        object.send("#{attr_name}=" + id_translation_table[object.id].to_s)
      end
    end
  end
end

def path_for(klass)
  "/home/drusepth/dump/app10401744/#{klass}.json"
end

classes_to_migrate = %w(users characters equipment languages locations magics universes)

db = {}
classes_to_migrate.each do |klass|
  puts "Loading #{klass} objects"
  db[klass] = load_objects(klass.singularize.titleize.constantize, path_for(klass))
end
