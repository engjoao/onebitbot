require_relative './../../spec_helper.rb'

describe LinkModule::CreateService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "with list command: With zero links, return don't find message" do
      @listService = ListModule::ListService.new({}, 'list')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "With two links, find address in response" do
      @listService = FaqModule::ListService.new({}, 'list')

      link1 = create(:link, company: @company)
      link2 = create(:link, company: @company)

      response = @listService.call()

      expect(response).to match(link1.address)
      expect(response).to match(link2.address)

    end

    it "with search command: With empty query, return don't find message" do
      @listService = LinkModule::ListService.new({'query' => ''}, 'search')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command: With valid query, find link address in response" do
      link = create(:link, company: @company)

      @listService = ListModule::ListService.new({'query' => link.address.split("/").sample}, 'search')

      response = @listService.call()
      expect(response).to match(link.address)
    end

    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      @listService = ListModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command: With valid hashtag, find link address in response" do
      link = create(:link, company: @company)
      hashtag = create(:hashtag)
      create(:link_hashtag, link: link, hashtag: hashtag)

      @listService = LinkModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')

      response = @listService.call()

      expect(response).to match(link.address)
    end
  end
end
