configs do
  description 'Default Git settings'
  version 0.1
  tags %w[git default]
  dependencies %w[]
end

set :scm, :git
set :git_enable_submodules, 1
set :git_shallow_clone, 1
