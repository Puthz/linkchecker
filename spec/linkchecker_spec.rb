require "spec_helper"
require "linkchecker"

describe LinkChecker do
  describe 'parse and check link' do
    context 'within html w/ working and broked links, respectively,' do
      it 'returning the status code from them' do
        parse = 'http://parse.link/'
        working = 'http://up.link/'
        error = 'http://down.link/'
        html1 = '<a href="http://up.link/">Working Link</a>
             <a href="http://down.link/">Broked Link</a>'
        test1 = [{ url: working, code: 200 }, { url: error, code: 404 }]
        WebMock.stub_request(:get, parse)
          .to_return(body: html1, status: 200)
        WebMock.stub_request(:get, working)
          .to_return(body: 'Hello World', status: 200)
        WebMock.stub_request(:get, error)
          .to_return(status: %w[404 Missing])
        checker = LinkChecker.new(parse).run

        expect(checker.size).to eq(2)
        expect(checker).to match_array(test1)
      end
    end
  end
end
