class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
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
      # redirect_to books_path
      # puts "Book saved successfully" , status: 201
      render json: @book
      
    else
      render xml: @book
      # render :new
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.title = params[:title]
    @book.author = params[:author]
    @book.genre = params[:genre]
    @book.quantity = params[:quantity]
    if @book.save
      # redirect_to show_books_path 
      # puts "Book updated successfully" , status: 302
      # render plain: "OK"
      # render html: helpers.tag.strong('Not Found')
      # render js: "alert('Hello Rails');"
    else
      # render :edit
      render plain: "Failed to update the book.", status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to show_books_path
  end

  def profile
  end
end
