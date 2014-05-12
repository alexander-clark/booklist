require 'spec_helper'

describe BooksController do

  let(:book) { mock_model(Book) }
  let(:book_attributes) { FactoryGirl.attributes_for(:book) }

  describe '#index' do

    before do
      expect(Book).to receive(:all).once.and_return([book])
      get :index
    end

    it { should respond_with(:success) }
    it { should render_with_layout :application }
    it { should render_template :index }

    it 'assigns the instance variable' do
      expect(assigns(:books)).to eq([book])
    end
  end

  describe '#show' do

    before do
      expect(Book).to receive(:find).with("#{book.id}").once.and_return(book)
      get :show, id: book
    end

    it { should respond_with(:success) }
    it { should render_with_layout :application }
    it { should render_template :show }

    it 'assigns the instance variable' do
      expect(assigns(:book)).to eq(book)
    end
  end

  describe '#new' do

    before do
      expect(Book).to receive(:new).once.and_return(book)
      get :new
    end

    it { should respond_with(:success) }
    it { should render_with_layout :application }
    it { should render_template :new }

    it 'assigns the instance variable' do
      expect(assigns(:book)).to eq(book)
    end
  end

  describe '#edit' do

    before do
      expect(Book).to receive(:find).with("#{book.id}").once.and_return(book)
      get :edit, id: book
    end

    it { should respond_with(:success) }
    it { should render_with_layout :application }
    it { should render_template :edit }

    it 'assigns the instance variable' do
      expect(assigns(:book)).to eq(book)
    end
  end

  describe '#create' do

    before do
      expect(Book).to receive(:new).with(book_attributes).once.and_return(book)
    end

    context 'success' do

      before do
        expect(book).to receive(:save).once.and_return(true)
        post :create, book: book_attributes
      end

      it { should set_the_flash.to('Book was successfully created.') }
      it { should redirect_to books_url }
    end

    context 'failure' do

      before do
        expect(book).to receive(:save).once.and_return(false)
        post :create, book: book_attributes
      end

      it { should respond_with(:success) }
      it { should render_with_layout :application }
      it { should render_template :new }

      it 'assigns the instance variable' do
        expect(assigns(:book)).to eq(book)
      end
    end
  end

  describe '#update' do
    before do
      expect(Book).to receive(:find).with("#{book.id}").once.and_return(book)
    end

    context 'success' do

      before do
        expect(book).to receive(:update_attributes).once.with(book_attributes).and_return(true)
        patch :update, id: book, book: book_attributes
      end

      it { should set_the_flash.to('Book was successfully updated.') }
      it { should redirect_to books_url }
    end

    context 'failure' do

      before do
        expect(book).to receive(:update_attributes).once.with(book_attributes).and_return(false)
        patch :update, id: book, book: book_attributes
      end

      it { should respond_with(:success) }
      it { should render_with_layout :application }
      it { should render_template :edit }

      it 'assigns the instance variable' do
        expect(assigns(:book)).to eq(book)
      end
    end
  end

  describe '#destroy' do

    before do
      expect(Book).to receive(:find).with("#{book.id}").once.and_return(book)
      expect(book).to receive(:destroy).and_return(book)
      delete :destroy, id: book
    end

    it { should redirect_to books_url }
  end
end
