require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)

    @address = FFaker::Internet.http_url
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @createService = LinkModule::CreateService.new({"address.original" => @address})

      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @createService = LinkModule::CreateService.new({"address.original" => @address,
                                                      "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, find the link in database" do
      @createService = LinkModule::CreateService.new({"address.original" => @address,
                                                      "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(Link.last.address).to eq(@address)
    end

    it "With valid params, hashtags are created" do
      @createService = LinkModule::CreateService.new({"address.original" => @address,
                                                      "hashtags.original" => @hashtags})

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to eq(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to eq(Hashtag.last.name)
    end
  end
end
