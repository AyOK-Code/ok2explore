RSpec.describe Ok2explore::Scraper do
  describe 'perform' do
    context 'when params are invalid' do
      context 'when not it valid list' do
        it 'raises an error' do
          expect { Ok2explore::Scraper.new(foo: 'bar') }.to raise_error(Ok2explore::Errors::InvalidParams)
        end
      end
    end
  end
end
