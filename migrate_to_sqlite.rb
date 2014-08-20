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

    # Store object in memory to create links later
    objects << memory_object
  end

  objects
end

def save_objects(id_translation_table, objects)
  objects.each do |object|
    # Grab the new ID for association migrations in the next step
    old_id = object.id

    # Delete the non-sqlite keys before saving
    object.id = nil

    puts object.inspect

    # Save to DB
    object.save!

    # Fetch the new ID and track old-->new
    id_translation_table[old_id] = object.reload.id
  end
end

def update_links(id_translation_table, objects)
  objects.each do |object|
    object.keys.select { |key| key.ends_with? '_id' }.each do |ref_key|
      object[ref_key] = id_translation_table[object._id]
    end
  end
end

def path_for(klass)
  "/home/drusepth/dump/app10401744/#{klass}.json"
end

classes_to_migrate = %w(users characters equipment languages locations magics universes)

id_translation = {}

db = {}
classes_to_migrate.each do |klass|
  puts "Loading #{klass} objects"
  db[klass] = load_objects(klass.singularize.titleize.constantize, path_for(klass))

  puts "Saving #{klass} objects"
  save_objects(id_translation, db[klass])
end

classes_to_migrate.each do |klass|
  puts "Linking #{klass} objects"
  update_links(id_translation, db[klass])
end