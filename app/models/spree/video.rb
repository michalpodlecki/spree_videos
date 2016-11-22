module Spree
  class Video < ActiveRecord::Base
    belongs_to :watchable, :polymorphic => true, :touch => true

    attr_accessor :product_id
    validates_presence_of :youtube_ref
    validates_uniqueness_of :youtube_ref, :scope => [:watchable_id, :watchable_type]

    def youtube_data
      youtube_data = Yt::Models::Video.new(id: youtube_ref)
      # youtube_data.instance_variable_set(:@unique_id, youtube_ref)
      # youtube_data.instance_variable_set(:@thumbnails, [OpenStruct.new(url: "https://i.ytimg.com/vi/#{youtube_ref}/default.jpg")])
      youtube_data
    end

    def youtube_link
      "https://www.youtube.com/watch?v=#{youtube_ref}"
    end

    def embed_html(html5_config = {}, youtube_url_params = {})
      if youtube_url_params.empty?
        youtube_data.embed_html
      else
        youtube_data.embed_html.sub(youtube_data.id, "#{youtube_data.id}?#{youtube_url_params.map{|k,v| "#{k}=#{v}"}.join('&')}")
      end
    end

    after_validation do
      youtube_ref.match(/(v=|\/)([\w-]+)(&.+)?$/) { |m| self.youtube_ref = m[2] }
      video_data_update
    end

    def video_data_update
      video = Yt::Video.new(id: youtube_ref)
      begin
        self.title        =  video.title unless self.title_changed?
        self.description  =  video.description
        self.duration     =  video.duration
        self.likes        =  video.like_count
        self.dislikes     =  video.dislike_count
        self.comments     =  video.comment_count
        self.views        =  video.view_count
        self.subscribers  =  video.favorite_count
        self.thumbnail_url = video.thumbnail_url
      rescue
      end
    end
  end
end
