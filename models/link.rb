require "will_paginate"

class Link < ActiveRecord::Base
  self.per_page = 20

  validates :url, presence: true, uniqueness: true

  after_validation :save_tags, on: [:create, :update]

  def self.get(params)
    tag = params.fetch("tag", nil)
    if tag.nil?
      Link.all.paginate(page: params[:page]).order(created_at: :desc)
    else
      Link.where("tags LIKE ?", "%#{tag}%").paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  protected

  def save_tags
    unless tags.blank?
      Tag.create_any_new_tags(tags)
    end
  end
end
