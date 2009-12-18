class ResponsesController < ApplicationController
  
  # GET /messages/message_id/responses.xml
  def index
    @messages = Message.find(params[:message_id]).responses
    respond_to do |format|
      format.xml { render :xml => @messages }
    end
  end
  
  # GET /messages/1/responses/new
  # GET /messages/1/responses/new.js
  def new
    @new_message = Message.find(params[:message_id]).responses.build
    @options = {:url => message_responses_path(:id => params[:message_id]), :method => :post}
    respond_to do |format| 
      format.html
      format.js
    end
  end

  # POST /messages/1/responses/1    
  # POST /messages/1/responses/1.xml  
  # POST /messages/1/responses/1.js  
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
        @options = {:url => message_responses_path(:id => params[:message_id]), :method => :post}
        format.html { @new_message = @message; render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        format.js   { @new_message = @message }
      end
    end
  end
  
  
end
