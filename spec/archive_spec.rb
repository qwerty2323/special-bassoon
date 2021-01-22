# frozen_string_literal: true

require 'archive'
require 'archive_shared'

describe Archive do
  it_behaves_like 'an archive utility', 'sentinels', 2
  it_behaves_like 'an archive utility', 'sniffers', 3
  it_behaves_like 'an archive utility', 'loopholes', 2
end
