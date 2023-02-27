RSpec.describe ArticlesHelper, type: :helper do
  context 'when status is draft' do
    let(:article_status) { 'draft' }
    let(:result) { "<span class='badge badge-warning'>#{article_status}</span>".html_safe }

    it 'return warning color label' do
      expect(status(article_status)).to eq(result)
    end
  end

  context 'when status is published' do
    let(:article_status) { 'published' }
    let(:result) { "<span class='badge badge-success'>#{article_status}</span>".html_safe }

    it 'return success color label' do
      expect(status(article_status)).to eq(result)
    end
  end
end
