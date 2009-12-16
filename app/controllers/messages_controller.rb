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
    @message = Message.new
    
    respond_to do |format| 
      format.html
      format.xml { render :xml => @messages }
    end
  end

  def create
    @message = Message.new(params[:message])
    if request.post? 
      if @message.save
        session[:user_name] = @message.user_name
        expire_page :action => 'update_wall'
        expire_page :action => 'wall'
      else
        flash[:notice] = "can't be empty!"
      end
      redirect_to :action => 'wall'
    end
  end
  
  def update_wall
    wall
    render :update do |page|
      page.replace_html 'shouts', :partial => 'messages'
    end
  end
  
end
