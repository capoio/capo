# Usage: RawRecipe.load_all
# This will return a hash of all recipes with their metadata

class RawRecipe
  attr_accessor :name
  attr_accessor :metadata
  attr_accessor :code
  attr_accessor :variables
  attr_accessor :code_block
  attr_accessor :settings_block

  def initialize name
    self.name = name
  end

  def parse
    self.metadata = parse_metadata
    self.code = parse_code
    self.variables = parse_variables
    self.code_block = parse_code_block
    self.settings_block = parse_settings_block
    self
  end

  def to_hash
    parse
    attributes_hash = {:name => name, :code => code, :variables => variables, code_block: code_block, settings_block: settings_block}
    metadata.each_pair{|k, v| attributes_hash[k] = v}
    attributes_hash
  end

  def self.load_all
    recipes = []
    Dir["#{File.dirname __FILE__}/../recipes/*"].each do |folder|
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

  def parse_variables
    raise 'Needs code to parse variables' if code.nil?
    variables = {}
    matched_variables = code.scan /set +\(?:(\w+)\)?, +'?"?:?(\w+)'?"?/
    matched_variables.each do |match_data|
      variables[match_data[0]] = match_data[1]
    end
    variables
  end

  def metadata_path
    path 'metadata.yml'
  end

  def parse_code_block
    code.match(/###### End sets.+#+(.*)/mi)[1]
  end

  def parse_settings_block
    code.match(/###### Begin sets(.*)###### End sets/mi)[1]
  end

  def code_path
    path "#{name}.rb"
  end

  def path file
   File.join File.dirname(__FILE__), "../recipes/#{name}/#{file}"
  end
end
