require 'pastie_client'
class Message < ActiveRecord::Base
  attr_accessor :message_type
  
  # Validations #
  validates_presence_of :body
  validate :valid_message_type

  # Callbacks #
  after_validation :send_code_to_pastie
  
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
      Message::Extensions::TYPES
    end
    
  end
  
  # Modules #
  module Extensions
    TYPES = { 0 => 'says', 1 => 'codes'}.freeze
  end

  def message_type=(msg_typ)
    @message_type = msg_typ.to_i
  end
  
  def send_code_to_pastie
    return true if message_type != 1
    
  end
  
  private
  
  def valid_message_type
    errors.add_to_base("Invalid message type") unless Message::Extensions::TYPES.keys.include?(message_type) or message_type.blank?
  end
  
  
end
