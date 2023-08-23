require 'rails_helper'

describe 'POST /bookmarks' do
    it 'valid bookmark attribute' do
        #send a post request with parameters
        post '/bookmarks', params: {
            bookmark: {
                url: 'google.com',
                title: 'new Test'
            }
        }

        # response should have http status
        expect(response.status).to eq(201)

        json = JSON.parse(response.body).deep_symbolize_keys
        
        expect(json[:url]).to eq('google.com')
        expect(json[:title]).to eq("new Test")
        
        # bookmark recor is created
        expect(Bookmark.last.title).to eq('new Test')
    end
    
    scenario 'invalid bookmark attributes' do
        post '/bookmarks', params: {
            bookmark: {
                url: '',
                title: 'new Title'
            }
        }
        
        # response should have HTTP status 201 created
        expect(response.status).to eq(422)
        
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(json[:url]).to eq(["can't be blank"])
        expect(Bookmark.count).to eq(0)

    end
end
