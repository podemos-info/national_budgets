# By preloading leaves, the hierarchy is loaded upwards following
# the references to superclasses in the class definitions.
=begin
models = Dir['app/models/*.rb']
byebug
Rails.autoloaders.main.preload models
=end
