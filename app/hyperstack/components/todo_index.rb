class TodoIndex < HyperComponent

  def create_new_todo_item
    Todo.create(title: @todo)
    @title = nil
  end

  render(DIV, class: 'ToDo') do
    IMG(class: 'Logo', src: 'assets/logo.png', alt: 'Hyperstack Logo')
    H1(class: 'ToDo-Header') { 'Hyperstack To Do' }
    DIV(class: 'ToDo-Container') do
      DIV(class: 'ToDo-Content') do
        Todo.each do |item|
          TodoItem(key: item, item: item.title)
          .on(:delete_item) { item.destroy }
        end
      end
      DIV do
        INPUT(type: :text, value: @title)
        .on(:change) { |e| mutate @title = e.target.value }
        .on(:enter) { create_new_todo_item }
        BUTTON(class: 'ToDo-Add') { '+' }
        .on(:click) { create_new_todo_item }
      end
    end
  end
end
