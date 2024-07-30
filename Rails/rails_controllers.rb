                 ---------------> ACTION CONTROLLER <----------------

* Action Controller is the C in MVC. 
* After the router has determined which controller to use for a request, the controller is responsible for making sense of 
  the request and producing the appropriate output.
* Action Controller does most of the groundwork for you and uses smart conventions to make this as straightforward as possible.
* A controller can thus be thought of as a middleman between models and views. 
* It makes the model data available to the view, so it can display that data to the user, and it saves or updates user data to the model.



===> Controller Naming Convention <===
* Singular Form for Model-Specific Controllers:-> 
    Use the singular form of the model name for the controller name. 
    For example, if you have a Book model, the controller should be named BooksController.

* Plural Form for Controller Name:-> 
    The controller name should be pluralized to represent the collection of resources. 
    For instance, BooksController for the Book model.

* Use Controller Suffix:-> 
    Always append Controller to the end of the controller name. 
    This helps in identifying the file as a controller and maintains consistency.

* CamelCase:-> 
    Use CamelCase for controller names. 
    For example, BooksController, AuthorsController, etc.

* Namespace for Different Contexts:-> 
    If you have controllers within different contexts or modules, use namespaces.  
    For instance, Admin::BooksController for admin-specific functionality.

* Resource Naming:-> 
    Controllers should typically be named after the resources they manage. 
    For example, OrdersController for handling orders

IMPORTANT:-> The controller naming convention differs from the naming convention of models, which are expected to be named in singular form.



====> Creating a Controller <====

$ rails generate controller Books
          or
$ rails g controller Books

This will create:
* A new file app/controllers/books_controller.rb
* A folder app/views/books/ with view files for actions like new, create, etc.
* A helper file app/helpers/books_helper.rb
* Routes in config/routes.rb if specified during generation.



=====> Controller Methods <=====
* index: Typically used to list all records of a particular model.
  Example:
    def index             # GET /books
      @books = Book.all
    end

* show: Used to display a single record.
  Example:
    def show             # GET /books/1
      @book = Book.find(params[:id])
    end

* new: Provides a form for creating a new record.
    Example:
    def new              # GET /books/new
      @book = Book.new
    end
  
    
* create: Processes the form submission from the new action to create a new record.
  Example:
    def create           # POST /books
      @book = Book.new(book_params)
      if @book.save
        redirect_to @book
      else
        render :new
      end
    end
    
* edit: Provides a form for editing an existing record.
  Example:
    def edit             # GET /books/1/edit
      @book = Book.find(params[:id])
    end
    
* update: Processes the form submission from the edit action to update an existing record.
  Example:
    def update           # PATCH/PUT /books/1
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to @book
      else
        render :edit
      end
    end
    
* destroy: Deletes a record.
  Example:
    def destroy          # DELETE /books/1
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_url
    end
    




=====> Creating Responses <=====
From the controllers point of view, there are three ways to create an HTTP response:

* Call render to create a full response to send back to the browser
* Call redirect_to to send an HTTP redirect status code to the browser
* Call head to create a response consisting solely of HTTP headers to send back to the browser