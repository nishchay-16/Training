class BooksController < ApplicationController
  layout "special_layout", only: [:special_action, :another_action]

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
      redirect_to books_path
      puts "Book saved successfully" , status: 201
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
      # redirect_to show_books_path 
      puts "Book updated successfully" , status: 200
      # render plain: "OK"
      # render html: helpers.tag.strong('Not Found')
      # render js: "alert('Hello Rails');"
      # render json: @book
      # render xml: @book

      # render plain: "Hello, world!", content_type: "text/plain"     # :content_type option for render
      # render :show, layout: "special_layout"                        # :layout option for render
      # render :show, layout: false
      # render xml: photo, location: photo_url(photo)                   # :location option for render

      # render action: "empty_list" 
    else
      render :edit
      # render plain: "Failed to update the book.", status: :unprocessable_entity
    end
  end


  def show
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      @books = Book.all
      flash.now[:alert] = "Your book was not found"
      render "index"
    end
  end
  

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to show_books_path
  end

  def profile
  end
end
