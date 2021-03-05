require "will_paginate"

class Tag < ActiveRecord::Base
  self.per_page = 20

  validates :name, presence: true, uniqueness: true

  def self.get(params)
    Tag.all.paginate(page: params[:page]).order(:name)
  end

  def self.create_any_new_tags(tags)
    tag_array = tags.split(",")
    tag_array.map { |t| Tag.find_or_create_by(name: t.downcase) }
  end
end
