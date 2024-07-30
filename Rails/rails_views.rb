                                     ----------> ACTION VIEW <----------

The "action view" refers to the component of the MVC (Model-View-Controller) architecture responsible for rendering HTML views and templates. 
It interacts with the controller and model to present data to the user.
Views are the templates where HTML is generated. They are typically written in ERB (Embedded Ruby) or HAML (HTML Abstraction Markup Language).
View files are usually located in the app/views directory and are organized by controller.


====> TEMPLATES
1) ERB
 Ruby code can be included using both <% %> and <%= %> tags. 
  * The <% %> tags are used to execute Ruby code that does not return anything, such as conditions, loops, or blocks.
  * The <%= %> tags are used when you want output.

  Example:
  <h1>Names of all the authors</h1>
  <% @authors.each do |author| %>
    Name: <%= author.author_name %><br>
  <% end %>

Here, The loop is set up using regular embedding tags (<% %>) and the name is inserted using the output embedding tags (<%= %>). 


