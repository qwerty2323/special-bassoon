# Matrix has you, Neo

# Usage
Firstly, you should fill `./config/config.yml`:
* url
* passphrase

## For single source type

```ruby
source = 'sentinels'
params = {
  passphrase: Config.passphrase,
  source: source
}
results = []
Server.get(Config.url, params) do |response|
  Archive.extract(response) do |content|
    results = converter.new.convert(content)
  end
end
results.each do |result|
  post_params = result.merge!(params)
  Server.post(link, post_params)
end
```

## For all source type at once

```ruby
results = []
Config.sources.each do |source|
  params = {
    passphrase: Config.passphrase,
    source: source
  }

  Server.get(Config.url, params) do |response|
    Archive.extract(response) do |content|
      results << converter.new.convert(content).merge!(params)
    end
  end
end
results.each do |result|
  Server.post(link, result)
end
```

# Specs
`spec/integration/full_spec.rb` tests full integration scenario with
http-requests
`spec/converters/*` check individual source type converter

# License
None needed
