require 'drb'
class MessagesController < ApplicationController

  # caches_page :wall
  # caches_action :update_wall
  
  def index
    if params[:history] || params[:page]
      @messages = Message.paginate :limit => 25, :page => params[:page]
    else
      @messages = Message.all(:limit => 12)
    end
    
    # create empty message object
    @new_message = Message.new
    
    respond_to do |format| 
      format.html
      format.js
      format.xml { render :xml => @messages }
    end
  end

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save
        # Save the submitted user name in the session for user's convenience #
        session[:user_name] = @message.user_name
        
        format.html { redirect_to messages_path }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
        format.js   { @new_message = Message.new }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        format.js   { @new_message = @message }
      end
    end
  end
  
end
