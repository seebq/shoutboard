require 'rubygems'
require 'coderay'
class Message < ActiveRecord::Base
  
  # Validations #
  validates_presence_of :body
  validate :valid_message_type
  
  # Scopes #
  default_scope :order => 'created_at DESC'
  
  # Class methods #
  class << self
    def calculate_rankings
      # do some crazy math here
      # manipulate a pdf, create a graphic file, upload to S3, etc.
      return 42
    end
    
    def message_types
      Message::Constants::TYPES
    end
    
    def default_message_type
      self.message_types.first
    end
    
  end
  
  # Modules #
  module Constants
    TYPES = %w(says codes).freeze
  end
  
  def is_code?
    'codes' == message_type
  end
  
  def to_highlighted_code
    CodeRay.scan(self.body, :ruby).div
  end
  
  private
  
  def valid_message_type
    errors.add_to_base("Invalid message type") unless Message.message_types.include?(message_type)
  end
  
  
end
