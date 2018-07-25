require "linkchecker/parser"

describe Parser do
  describe "#run" do
    context "when url is nil or empty" do
      it "should return an empty array" do
        parser = Parser.new(nil)

        expect(parser.run).to eq []
      end
    end

    context "when url is not nil" do
      it "should return a list of links" do
        url = "http://test.me/"
        parser = Parser.new(url)
        WebMock.stub_request(:get, url).
          to_return(body: "<a href=\"#{url}\"></a>")

        expect(parser.run).to eq [url]
      end
    end
  end
end
