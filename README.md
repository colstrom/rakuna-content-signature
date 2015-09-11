# rakuna-content-signature

Content signatures for Rakuna and Webmachine!

# Description

Adds support for HMAC signatures with optional shared secrets to your Webmachine resources.

# Installation
`gem install rakuna-content-signature`

# Usage
`require 'rakuna/validation/signature'`

## Examples

### Rejecting a payload with a missing or invalid signature.
```ruby
class ExampleResource < Rakuna::Resource::Action
  include Rakuna::Validation::Signature

  def malformed_request?
    true unless signature_valid?
  end
end
```

### Validating a GitHub payload
```ruby
class ExampleResource < Rakuna::Resource::Action
  include Rakuna::Validation::Signature

  def signature_secret
    ENV['GITHUB_SECRET']
  end

  def content_signature
    request.headers['X-Hub-Signature']
  end

  def malformed_request?
    true unless signature_valid?
  end
end
```



# Contributing
  * Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
  * Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
  * Fork the project.
  * Start a feature/bugfix branch.
  * Commit and push until you are happy with your contribution.
  * Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# License
[MIT](https://tldrlegal.com/license/mit-license)

# Contributors
  * [Chris Olstrom](https://colstrom.github.io/) | [e-mail](mailto:chris@olstrom.com) | [Twitter](https://twitter.com/ChrisOlstrom)
