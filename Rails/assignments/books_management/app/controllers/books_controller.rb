class BooksController < ApplicationController
  def index
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new
    @book.title = params[:title]
    @book.author = params[:author]
    @book.genre = params[:genre]
    @book.quantity = params[:quantity]
    if @book.save
      redirect_to books_path
      puts "Book saved successfully"
    else
      render :new
    end
  end

  def show
    @books = Book.all
  end

end
