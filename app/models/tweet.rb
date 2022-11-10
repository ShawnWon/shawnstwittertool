class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: {minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do 
	self.publish_at ||= 24.hours.from_now
  end

  after_save_commit do
	if publish_at_previously_changed?
		TweetJob.perform_at(self.publish_at, self.id)
	end
  end

  def published?
	tweet_id?
  end

  def publish_to_twitter!
	tweet = twitter_account.client.update(body)
	update(tweet_id: tweet.id)
  end
end
