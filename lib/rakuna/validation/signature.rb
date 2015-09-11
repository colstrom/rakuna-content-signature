require 'contracts'
require 'rakuna/content/signature'

if RUBY_ENGINE == 'jruby'
  require 'secure_compare'
  SECURE_COMPARE = SecureCompare
else
  require 'fast_secure_compare/fast_secure_compare'
  SECURE_COMPARE = FastSecureCompare
end

module Rakuna
  module Validation
    module Signature
      include Contracts
      include Rakuna::Content::Signature

      Contract None => Maybe[String]
      def content_signature
        @content_signature ||= request.headers['X-Content-Signature']
      end

      Contract None => Bool
      def signature_valid?
        return false unless content_signature
        SECURE_COMPARE.compare content_signature, signature.generate(request.body.to_s)
      end
    end
  end
end
