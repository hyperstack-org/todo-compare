class Todo < HyperComponent
  INITIAL_TODOS = [
    {
      todo: 'clean the house'
    },
    {
      todo: 'buy milk'
    }
  ]

  before_mount { @list = INITIAL_TODOS.dup }

  def create_new_todo_item
    mutate @list << { todo: @todo }, @todo = nil
  end

  render(DIV, class: 'ToDo') do
    IMG(class: 'Logo', src: 'assets/logo.png', alt: 'Hyperstack Logo')
    H1(class: 'ToDo-Header') { 'Hyperstack To Do' }
    DIV(class: 'ToDo-Container') do
      DIV(class: 'ToDo-Content') do
        @list.each do |item|
          TodoItem(key: item, item: item[:todo])
          .on(:delete_item) { mutate @list.delete(item) }
        end
      end
      DIV do
        INPUT(type: :text, value: @todo)
        .on(:change) { |e| mutate @todo = e.target.value }
        .on(:enter) { create_new_todo_item }
        BUTTON(class: 'ToDo-Add') { '+' }
        .on(:click) { create_new_todo_item }
      end
    end
  end
end
