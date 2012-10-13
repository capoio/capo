configs do
  description 'Default Git settings'
  version 0.2
  tags %w[git scm]
  category 'defaults'
  dependencies %w[]
end

set :scm, :git
set :git_enable_submodules, 1
set :git_shallow_clone, 1
