class BooksController < ApplicationController
  def index                                      # GET /books
    @books = Book.all
  end

  def show                                       # GET /books/1
    @book = Book.find(params[:id])
  end

  def new                                        # GET /books/new
    @book = Book.new
  end

  def create                                     # POST /books
    @book = Book.new(book_params)
    if @book.save
      HardJob.perform_at(5.minutes.from_now, @book.title, 5)
      WelcomeMailer.welcome_email(@book).deliver_later(wait: 5.minutes)
      SocialMediaPostJob.perform_at(2.minutes, 'twitter', 'Hello World! Scheduled tweet.')

      redirect_to @book
    else
      render :new
    end
  end

  def edit                                        # GET /books/1/edit
    @book = Book.find(params[:id])
  end

  def update                                      # PATCH/PUT /books/1
    @book = Book.find(params[:id])
    if @book.update(book_params)
      WelcomeMailer.update_email(@book).deliver_later
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy                                     # DELETE /books/1
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url
  end

  def preview
    @book = Book.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author_id, :isbn, :quantity, :available_quantity, :genre_id)
  end
end