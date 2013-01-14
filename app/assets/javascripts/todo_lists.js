
window.Todo || (window.Todo = {});


// initialize javascript on page All Todo Lists
// =========================================================
Todo.initAllTodoListPage = function() {
  var $todo_lists;
  $('.sortable-todo-list').disableSelection();
  $todo_lists = $('.sortable-todo-list');

  // make all TodoList able to sorting
  //
  $todo_lists.each(function(idx_todo, todo) {
    var $todo_list_container, todo_list_id;
    $todo_list_container = $(todo);
    todo_list_id = $todo_list_container.attr('data-todo-list');
    $todo_list_container.disableSelection();

    // initialize sortable
    $todo_list_container.sortable({
      connectWith: '.sortable-todo-list',
      cursor: "move",
      placeholder: "ui-state-highlight",

      stop: function(event, ui) {
        var $todo_items, row, todo_item_id;
        todo_item_id = $(ui.item).attr('data-todo-item');
        $todo_items = $todo_list_container.find('li');
        row = null;

        $todo_items.each(function(idx, elem) {
          $(elem).find('span.order-number').html(idx + 1);
          if ($(elem).attr('data-todo-item') === todo_item_id) {
            return row = idx;
          }
        });

        // send request to API to update the Row
        $.post('/todo_lists/' + todo_list_id + '/update_row', {
          todo_item_id: todo_item_id,
          row: row
        });

      },

      receive: function(event, ui) {
        var $target_todo, from_todo_list_id, row, to_todo_list_id, todo_item_id;

        todo_item_id = $(ui.item).attr('data-todo-item');
        from_todo_list_id = $(ui.item).attr('data-todo-list');
        $target_todo = $(ui.item).closest('ul');
        to_todo_list_id = $target_todo.attr('data-todo-list');
        $(ui.item).attr('data-todo-list', to_todo_list_id);
        row = null;

        $target_todo.find('li').each(function(idx, elem) {
          $(elem).find('span.order-number').html(idx + 1);
          if ($(elem).attr('data-todo-item') === todo_item_id) {
            return row = idx;
          }
        });

        // send request to API to update the Row
        $.post('/todo_lists/move_row', {
          target_todo_list_id: to_todo_list_id,
          from_todo_list_id: from_todo_list_id,
          todo_item_id: todo_item_id,
          row: row
        });

      }
    });
  });
};


// Not used anymore
// ====================================================
Todo.initShowTodoPage = function() {
  var $todo_list_container, todo_list_id;
  $todo_list_container = $("#todo-items-container");
  todo_list_id = $todo_list_container.attr('data-todo-list');
  $todo_list_container.disableSelection();
  return $todo_list_container.sortable({
    stop: function(event, ui) {
      var $todo_items, row, todo_item_id;
      todo_item_id = $(ui.item).attr('data-todo-item');
      $todo_items = $todo_list_container.find('tr');
      row = null;
      $todo_items.each(function(idx, elem) {
        $(elem).find('span.order-number').html(idx + 1);
        if ($(elem).attr('data-todo-item') === todo_item_id) {
          return row = idx;
        }
      });
      return $.post('/todo_lists/' + todo_list_id + '/update_row', {
        todo_item_id: todo_item_id,
        row: row
      });
    }
  });
};


// This function used for add dynamic field task item when create new Todo List
// ==================================================================
Todo.addFormTodoItem = function(template) {
  var partial, unique_id;
  unique_id = new Date().getTime();
  partial = template.replace(/UNIQUE_ID/g, unique_id);
  $('#form-todo-item-container').append(partial);
};
