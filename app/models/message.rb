class Message < ActiveRecord::Base
  validates_presence_of :body
  default_scope :order => 'created_at DESC'

  def self.calculate_rankings
    # do some crazy math here
    # manipulate a pdf, create a graphic file, upload to S3, etc.
    return 42
  end
  
end
