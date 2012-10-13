configs do
  description 'Default svn settings'
  version 0.1
  tags %w[svn scm]
  category 'defaults'
  dependencies %w[]
end

set :scm, :svn

# Asks for a password for your repository but authentication via ssh is recmmended
#set :scm_password, Proc.new {CLI.password_prompt 'SVN Password: '}

# Set password for scm but using ssh key is recommended
# set :scm_passphrase, "p@ssw0rd"  # The deploy user's password
