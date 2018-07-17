require 'linkchecker'

require "httparty"
require "nokogiri"
require "colorize"
require "rspec"
require "fakeweb"



describe LinkChecker do 

    describe "parse and check link" do



        context "within html w/ working and broked links, respectively," do
            it "returning the status code from them" do

                @parse = URI('http://parse.link/')
                FakeWeb.register_uri(:get, @parse.to_s, :body =>'<a href="http://up.link">Working Link</a><a href="http://down.link">Broked Link</a>')

                @working = URI('http://up.link/')
                FakeWeb.register_uri(:get, @working.to_s, :body => "Hello World!")

                @error = URI('http://down.link/')
                FakeWeb.register_uri(:get, @error.to_s,
                  :body => "Not found", :status => ["404", "Missing"])

                bool = LinkChecker.new(@parse.to_s).run == [200,404]
                expect(bool).to be true  
            end
        end
    end
end

