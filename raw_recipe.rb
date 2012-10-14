# Usage: RawRecipe.load_all
# This will return a hash of all recipes with their metadata

class RawRecipe
  attr_accessor :name
  attr_accessor :metadata
  attr_accessor :code

  def initialize name
    self.name = name
  end

  def parse
    self.metadata = parse_metadata
    self.code = parse_code
    self
  end

  def to_hash
    parse
    attributes_hash = {:name => name, :code => code}
    metadata.each_pair{|k, v| attributes_hash[k] = v}
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
    metadata_hash = YAML.load File.read metadata_path
    metadata_hash.inject({}){|h, (k, v)| h[k.to_sym] = v; h} # symbolize keys
  end

  def parse_code
    File.read code_path
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
