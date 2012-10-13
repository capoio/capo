configs do
  description 'Default Git settings'
  version 0.2
  tags %w[git scm]
  category 'defaults'
  dependencies %w[]
end

set :scm, :git

# Enable submodule to be updated
set :git_enable_submodules, 1

# Only deploy shallow clone, this will not clone the whole git history, just the latest state.
set :git_shallow_clone, 1

# Set password for scm, using ssh key is recommended
# set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
