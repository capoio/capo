configs do
  description 'Default ssh settings'
  version 0.1
  tags %w[default ssh]
  category 'defaults'
  dependencies %w[]
end

ssh_options[:forward_agent] = true
