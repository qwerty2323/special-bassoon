# frozen_string_literal: true

require 'converter'
require 'converter_shared'

describe Converter do
  it_behaves_like 'a factory', 'sentinels'
  it_behaves_like 'a factory', 'sniffers'
  it_behaves_like 'a factory', 'loopholes'

  context 'when passing non-existent converted' do
    it 'raises NoMethodError' do
      expect { Converter.for(:non_existing).new }.to raise_error(NoMethodError)
    end
  end
end
