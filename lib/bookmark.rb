# frozen_string_literal: true

require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @title = title
    @url = url
  end

  def self.delete(id:)
    if ENV['Environment'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.all
    conn = if ENV['RACK_ENV'] == 'test'
             PG.connect(dbname: 'bookmark_manager_test')
           else
             PG.connect(dbname: 'bookmark_manager')
           end
    result = conn.exec('SELECT * FROM bookmarks')

    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(new_url, title)
    conn = if ENV['RACK_ENV'] == 'test'
             PG.connect(dbname: 'bookmark_manager_test')
           else
             PG.connect(dbname: 'bookmark_manager')
           end
    result = conn.exec("INSERT INTO bookmarks (url, title) VALUES ('#{new_url}', '#{title}') RETURNING id, url, title")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }.first
    # Bookmark.new(result[:url], result[2])
  end
end
