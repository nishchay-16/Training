class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
  end

  def edit
    @book = Book.find(params[:id])
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

  def update
    @book = Book.find(params[:id])
    @book.title = params[:title]
    @book.author = params[:author]
    @book.genre = params[:genre]
    @book.quantity = params[:quantity]
    if @book.save
      redirect_to show_books_path
      puts "Book updated successfully"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to show_books_path
  end

end
