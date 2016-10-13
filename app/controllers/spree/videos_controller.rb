module Spree
  class VideosController < BaseController
    respond_to :html
    
    def index
      @videos = Video.all.joins(:product).where('spree_products.deleted_at is NULL')
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

      @client = YouTubeIt::Client.new
    end
  end
end
