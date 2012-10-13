class Recipe
  attr_accessor :name
  attr_accessor :attributes_hash

  def initialize name
    self.attributes_hash = {}
    self.name = name
  end

  def to_hash
    attributes_hash[:name] = name
    parse_metadata
    load_code
    attributes_hash
  end

  private
  def parse_metadata
    metadata = YAML.load File.read(metadata_path)
    metadata.each_pair do |name, value|
      attributes_hash[name.to_sym] = value
    end
  end

  def load_code
    code = File.read(code_path)
    attributes_hash[:code] = code
  end

  def metadata_path
    path 'metadata.yml'
  end

  def code_path
    path "#{name}.rb"
  end

  def path file
   File.join File.dirname($0), "recipes/#{name}/#{file}"
  end
end

class Recipes
  def self.load
    recipes = []
    Dir['recipes/*'].each do |folder|
      name = folder.match(/^recipes\/(\w+)$/)[1]
      recipes << Recipe.new(name).to_hash
    end
    recipes
  end
end

puts Recipes.load.inspect
