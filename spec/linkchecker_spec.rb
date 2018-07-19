require 'linkchecker'
require 'httparty'
require 'nokogiri'
require 'colorize'
require 'rspec'
require 'webmock'
include WebMock::API

WebMock.enable!

describe LinkChecker do
  describe 'parse and check link' do
    parse = 'http://parse.link/'
    working = 'http://up.link/'
    error = 'http://down.link/'
    html1 = '<a href="http://up.link">Working Link</a>
             <a href="http://down.link">Broked Link</a>'

    WebMock.stub_request(:get, parse)
           .to_return(body: html1, status: 200)
    WebMock.stub_request(:get, working)
           .to_return(body: 'Hello World', status: 200)
    WebMock.stub_request(:get, error)
           .to_return(status: %w[404 Missing])

    # FakeWeb.register_uri(:get, @parse.to_s, :body =>
    # FakeWeb.register_uri(:get, @working.to_s, :body => "Hello World!")
    # FakeWeb.register_uri(:get, @error.to_s,
    #   :body => "Not found", :status => ["404", "Missing"])

    context 'within html w/ working and broked links, respectively,' do
      it 'returning the status code from them' do
        bool = LinkChecker.new(parse).run == [200, 404]
        expect(bool).to be true
      end
    end
  end
end
