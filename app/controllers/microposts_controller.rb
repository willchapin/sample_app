class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :micropost_author, only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
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
      @micropost = Micropost.find_by_id(params[:id])
      @user = @micropost.user
      redirect_to root_path unless current_user?(@user)
    end

  

end
