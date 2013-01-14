# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Todo ||= {}


Todo.initAllTodoListPage = ()->
  $('.sortable-todo-list').disableSelection()
  $todo_lists = $('.sortable-todo-list')
  $todo_lists.each (idx_todo, todo)->
    $todo_list_container = $( todo )
    todo_list_id = $todo_list_container.attr('data-todo-list')
    $todo_list_container.disableSelection()
    $todo_list_container.sortable
      connectWith: '.sortable-todo-list'
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

      receive: (event, ui)->
        todo_item_id      = $(ui.item).attr('data-todo-item')
        from_todo_list_id = $(ui.item).attr('data-todo-list')
        $target_todo      = $(ui.item).closest('tbody')
        to_todo_list_id   = $target_todo.attr('data-todo-list')
        $(ui.item).attr('data-todo-list', to_todo_list_id)
        row = null
        $target_todo.find('tr').each (idx, elem)->
          $(elem).find('span.order-number').html(idx+1)
          if $(elem).attr('data-todo-item') == todo_item_id
            row = idx

        # post data to server
        $.post '/todo_lists/move_row'
          target_todo_list_id: to_todo_list_id
          from_todo_list_id: from_todo_list_id
          todo_item_id: todo_item_id
          row: row

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
