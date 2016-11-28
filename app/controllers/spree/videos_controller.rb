module Spree
  class VideosController < BaseController
    respond_to :html
    
    def index
      @videos = Video.all.map{|video| video if video.watchable && video.watchable.try(:deleted_at).nil?}.compact
    end

    def product_index
      @product = Product.find_by(slug: params[:product_id])
      @videos = @product.videos.all(order: 'position')
    end

    def show
      if params[:youtube_ref]
        @video = Video.find_by(youtube_ref: params[:youtube_ref])
      else params[:id]
        @video = Video.find(params[:id])
      end

      # @client = Yt::Client.new
    end
  end
end
