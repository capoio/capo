configs do
  description 'Default svn settings'
  version 0.1
  tags %w[svn scm]
  category 'defaults'
  dependencies %w[]
end

set :scm, :svn
set :scm_password, Proc.new {CLI.password_prompt 'SVN Password: '}
