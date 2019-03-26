require 'spec_helper'

describe 'Todo App' do
  context 'TodoItem', js: true do
    before(:each) do
      mount 'TodoItem', item: 'a test todo'
    end

    it 'displays the correct text' do
      expect(find('.ToDoItem-Text').text).to eq('a test todo')
    end

    it 'raises the delete event when the delete button is clicked' do
      find('.ToDoItem-Delete').click
      expect(event_history_for(:delete_item)).to eq([[]]) # single empty event with no params
    end
  end

  context 'TodoIndex', js: true do
    it "lists the todos" do
      mount 'TodoIndex' do
        TodoIndex::INITIAL_TODOS = 4.times.collect { |i| { todo: "Todo - #{i}" }}
      end
      expect(page).to have_selector('.ToDoItem-Text', count: 4)
    end
    it "can add a new todo using the enter key" do
      mount 'TodoIndex' do
        TodoIndex::INITIAL_TODOS = []
      end
      find('input').set("a new todo\n")
      expect(find('.ToDoItem-Text').text).to eq('a new todo')
    end
    it "can add a new todo using the button" do
      mount 'TodoIndex' do
        TodoIndex::INITIAL_TODOS = []
      end
      find('input').set("a new todo")
      find('.ToDo-Add').click
      expect(find('.ToDoItem-Text').text).to eq('a new todo')
    end
  end
end
