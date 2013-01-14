<% if @success %>
  <%=  add_gritter('Success move task items', :image => :success) %>
<% else %>
  <%=  add_gritter('Error move task items', :image => :error) %>
<% end %>