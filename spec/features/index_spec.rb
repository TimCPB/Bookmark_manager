# frozen_string_literal: true

require 'sinatra'

feature 'Bookmark Manager' do
  scenario 'it should produce bookmark homepage' do
    visit '/'
    expect(page).to have_link('View Bookmarks', href: 'http://localhost:9292/bookmarks')
  end
end
