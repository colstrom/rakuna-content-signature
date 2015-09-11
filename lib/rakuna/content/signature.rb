require 'contracts'
require 'openssl'

module Rakuna
  module Content
    module Signature
      include Contracts

      class ContentSignature
        include Contracts

        Contract String => Any
        def initialize(secret)
          @secret = secret
        end

        Contract None => OpenSSL::Digest
        def digest
          @digest ||= OpenSSL::Digest::SHA1.new
        end

        Contract Maybe[String] => String
        def generate(content)
          [
            digest.name.downcase,
            '=',
            OpenSSL::HMAC.hexdigest(digest, @secret, content)
          ].join ''
        end
      end

      Contract None => String
      def signature_secret
        ENV.fetch 'CONTENT_SIGNING_SECRET', ''
      end

      Contract None => ContentSignature
      def signature
        @signature ||= ContentSignature.new signature_secret
      end
    end
  end
end
