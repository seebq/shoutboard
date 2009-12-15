require 'drb'
class MessagesController < ApplicationController

  # caches_page :wall
  # caches_action :update_wall
  
  def wall
    @messages = Message.find(:all, :limit => 12, :order => 'created_at DESC')
  end

  def shout
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
  
  def history
    @messages = Message.find(:all, :order => 'created_at DESC')
  end
  
  def update_wall
    wall
    render :update do |page|
      page.replace_html 'shouts', :partial => 'messages'
    end
  end
  
end
