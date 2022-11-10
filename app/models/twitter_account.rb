class TwitterAccount < ApplicationRecord
	validates :username, uniqueness: true
      	belongs_to :user
	has_many :tweets, dependent: :destroy

	def client
	  Twitter::REST::Client.new do |config|
	    config.consumer_key        = Rails.application.credentials.dig(:twitter, :api_key)

	    config.consumer_secret     = Rails.application.credentials.dig(:twitter, :api_secret)

	    config.access_token        = token
	    config.access_token_secret = secret
	  end
	end
end
