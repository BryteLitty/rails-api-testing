require 'rails_helper'

describe 'PUT /bookmarks' do
    let!(:bookmark) { Bookmark.create(url: 'google.com', title: 'new Test') }

    it 'valid bookmark attributes' do
        put "/bookmarks/#{bookmark.id}", params: {
            bookmark: {
                url: 'fluffy.co',
                title: 'Fluffy'
            }
        }

        expect(response.status).to eq(200)

        json = JSON.parse(response.body).deep_symbolize_keys
        
        expect(json[:url]).to eq('fluffy.co')
        expect(json[:title]).to eq("Fluffy")

        expect(bookmark.reload.url).to eq('fluffy.co')
        expect(bookmark.reload.title).to eq('Fluffy')
    end

    it 'invalid bookmart attributes' do
        put "/bookmarks/#{bookmark.id}", params: {
            bookmark: {
                url: '',
                title: 'Fluffy'
            }
        }

        expect(response.status).to eq(422)

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:url]).to eq(["can't be blank"])

        expect(bookmark.reload.title).to eq('new Test')
        expect(bookmark.reload.url).to eq('google.com')
    end
end