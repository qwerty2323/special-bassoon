# frozen_string_literal:true

shared_examples 'fully functioning server' do |source|
  let(:params) do
    {
      passphrase: Config.passphrase,
      source: source
    }
  end
  let(:link) { Config.url }
  let(:converter) { Converter.for(source.to_sym) }

  it "receives, converts and posts data from #{source}" do
    results = []
    Server.get(link, params) do |response|
      Archive.extract(response) do |content|
        results = converter.new.convert(content)
      end
    end
    results.each do |result|
      post_params = result.merge!(params)
      response = Server.post(link, post_params)
      expect(response.code).to eql '201'
    end
  end
end
