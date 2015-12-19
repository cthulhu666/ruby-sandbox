require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do
  describe 'POST freeze' do
    let(:snippet) do
      FactoryGirl.create(:snippet)
    end
    let(:attr) do
      { code: '# foofoo', spec: '# barbar' }
    end

    before(:each) do
      put :freeze, id: snippet.id, snippet: attr
      snippet.reload
    end

    it do
      expect(snippet.is_frozen).to be_truthy
      expect(snippet.code).to eq attr[:code]
      expect(snippet.spec).to eq attr[:spec]
    end
  end
end
