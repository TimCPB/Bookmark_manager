# frozen_string_literal: true

require 'bookmark'
require 'bookmark_helper'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    add_test_data
    bookmarks = Bookmark.all
    it 'return a list instances' do
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks[1]).to be_an_instance_of(Bookmark)
      expect(bookmarks[1].url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create('test.url', 'title')
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark).to be_an_instance_of(Bookmark)
      expect(bookmark.url).to eq('test.url')
      expect(bookmark.title).to eq('title')
      expect(bookmark.id).to eq persisted_data['id']
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create('http://www.makersacademy.com', 'Makers Academy')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end
end
