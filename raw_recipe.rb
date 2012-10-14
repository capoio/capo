# Usage: RawRecipe.load_all
# This will return a hash of all recipes with their metadata

class RawRecipe
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

  def self.load_all
    recipes = []
    Dir["#{File.dirname __FILE__}/recipes/*"].each do |folder|
      name = folder.match(/recipes\/(\w+)$/)[1]
      recipes << new(name).to_hash
    end
    recipes
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
   File.join File.dirname(__FILE__), "recipes/#{name}/#{file}"
  end
end