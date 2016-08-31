require 'will_paginate'

class Link < ActiveRecord::Base
  self.per_page = 20

  validates :url, presence: true, uniqueness: true

  after_validation :save_tags, on: [ :create, :update ]

  def self.get(params)
    tag = params.fetch('tag', nil)
    if tag.nil?
      links = Link.all.paginate(:page => params[:page]).order(created_at: :desc)
    else
      links = Link.where("tags LIKE ?", "%#{tag}%").paginate(:page => params[:page]).order(created_at: :desc)
    end
    links
  end

  protected
    def save_tags
      unless self.tags.blank?
        Tag.create_any_new_tags(self.tags)
      end
    end
end
