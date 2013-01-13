# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Todo ||= {}


# Initialize detail todo page
Todo.initShowTodoPage = ()->
  $todo_list_container = $( "#todo-items-container" )
  todo_list_id = $todo_list_container.attr('data-todo-list')
  $todo_list_container.disableSelection()
  $todo_list_container.sortable
    stop: (event, ui)->
      todo_item_id = $(ui.item).attr('data-todo-item')
      $todo_items = $todo_list_container.find('tr')
      row = null
      $todo_items.each (idx, elem)->
        $(elem).find('span.order-number').html(idx+1)
        if $(elem).attr('data-todo-item') == todo_item_id
          row = idx

      # post data to server
      $.post '/todo_lists/' + todo_list_id + '/update_row'
        todo_item_id: todo_item_id
        row: row



# add dynamic form todo item
Todo.addFormTodoItem = (template)->
  unique_id = new Date().getTime()
  partial = template.replace(/UNIQUE_ID/g,unique_id)
  $('#form-todo-item-container').append(partial)
