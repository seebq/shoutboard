require 'rubygems'
require 'coderay'
class Message < ActiveRecord::Base
  
  has_many    :responses, :class_name => "Message", :foreign_key => :parent_id, :order => "created_at ASC"
  belongs_to  :parent,    :class_name => "Message"
  
  # Validations #
  validates_presence_of :body
  validate :valid_message_type, :first_level_child
  
  # Scopes #
  default_scope :order => 'created_at DESC'
  named_scope   :parents, :conditions => {:parent_id => nil}
  
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
  
  # Override user_name getter to return "anonymous" if blank
  def user_name
    read_attribute('user_name') || "anonymous"
  end

  
  private
  
  def valid_message_type
    errors.add(:quantity,"Invalid message type") unless Message.message_types.include?(message_type)
  end
  
  def first_level_child
    errors.add(:parent_id, "You cannot respond to another shout response.") if (!self.parent_id.blank? && !parent.parent_id.blank?)
  end
  
  
end
