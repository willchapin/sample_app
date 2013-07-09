class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :micropost_author, only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = current_user.feed
      render 'static_pages/home'
    end

  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost destroyed."
    redirect_to root_path
  end


  private

    def micropost_author
      @micropost = current_user.microposts.find_by_id(params[:id])
    rescue
      redirect_to root_path 
    end

  

end
