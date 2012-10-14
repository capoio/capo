##################################################
###### Begin sets

set :scm, :git

# Enable submodule to be updated
set :git_enable_submodules, 1

# Only deploy shallow clone, this will not clone the whole git history, just the latest state.
set :git_shallow_clone, 1

# Asks for a password for your repository but authentication via ssh is recmmended
#set :scm_password, Proc.new {CLI.password_prompt 'GIT Password: '}

# Set password for scm, using ssh key is recommended
# set :scm_passphrase, "p@ssw0rd"  # The deploy user's password

###### End sets
##################################################
