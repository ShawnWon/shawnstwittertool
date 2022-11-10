class TweetJob
  include Sidekiq::Job

  def perform(id)
    tweet = Tweet.find(id)
    return if tweet.published?
    return if tweet.publish_at > Time.current
    tweet.publish_to_twitter!
  end
end
