# frozen_string_literal:true

require 'integration_spec/full_shared'

%w[archive config converter server].each do |item|
  require item
end

describe 'System test' do
  it_behaves_like 'fully functioning server', 'sentinels'
  it_behaves_like 'fully functioning server', 'sniffers'
  it_behaves_like 'fully functioning server', 'loopholes'
end
