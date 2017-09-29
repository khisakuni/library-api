require 'rails_helper'

describe UserBooksFilter do
  describe '#filter' do
    let(:author_1) { 'Author One' }
    let(:author_2) { 'Author Two' }
    let(:user) { create(:user) }
    let(:book_1) { create(:book, title: 'Book 1', author: author_1) }
    let(:book_2) { create(:book, title: 'Book 2', author: author_1) }
    let(:book_3) { create(:book, title: 'Book 3', author: author_2) }

    before(:each) do
      [book_1, book_2, book_3].each do |book|
        create(:user_book, user: user, book: book)
      end
    end

    it 'filters by author' do
      filter = UserBooksFilter.new(user.user_books, author: author_2)
      result = filter.perform

      expect(result.size).to eq(Book.where(author: author_2).size)
      expect(result.first.book.author).to eq(author_2)
    end

    it 'filters by read' do
      expected = UserBook.last
      expected.update(read: true)
      filter = UserBooksFilter.new(user.user_books, read: true)
      result = filter.perform

      expect(result.size).to eq(UserBook.where(read: true).size)
      expect(result.first.read).to eq(true)
    end
  end
end
