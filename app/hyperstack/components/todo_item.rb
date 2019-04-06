class TodoItem < HyperComponent
  param :item
  fires :delete_item
  render(DIV, class: 'ToDoItem') do
    P { 'xx' }
    P(class: 'ToDoItem-Text') { @Item }
    BUTTON(class: 'ToDoItem-Delete'){ '-' }.on(:click) { delete_item! }
  end
end
