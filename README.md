# The Exact Same App In Hyperstack

This is repo contains a complete working Todo app, originally described in an excellent [blog post](https://medium.com/javascript-in-plain-english/i-created-the-exact-same-app-in-react-and-vue-here-are-the-differences-e9a1ae8077fd) by [Sunil Sandhu](https://medium.com/@sunilsandhu) that compares Vue and React.

I took the same app and converted it to Ruby using the [Hyperstack](https://hyperstack.org) framework.  The results are documented in a series of blog posts on Medium:

+ [Part I](https://medium.com/@mitch_23203/the-exact-same-app-in-hyperstack-7f281cef46ca)
+ Part II (coming soon)
+ Part III (coming soon)

#### Structure of The Hyperstack App

A Hyperstack App is a Rails Application with an additional `hyperstack` directory.  Almost all the coding takes place in this `app/hyperstack` directory.  This is all setup for you when you install Hyperstack. Here is the structure of the `app` directory:

```
app
├── assets ...
├── channels ...
├── controllers ...
├── helpers ...
├── hyperstack
│   ├── components
│   │   ├── hyper_component.rb
│   │   ├── todo_index.rb
│   │   └── todo_item.rb
│   ├── models ...
│   ├── operations ...
│   └── stores ...
├── javascript ...
├── jobs ...
├── mailers ...
├── models ...
├── policies ...
└── views ...
```

In addition to the `app` directory you will see the usual Rails `config` directory and `db` directories, which we can ignore as they are all setup for us with good working defaults.

You will also see a `spec` directory which is where specs are placed.  Specifically there is one spec file called `todo_spec.rb`.

#### Comparing to Vue and React

At the top level you will find a `comparisons` directory with the Vue and React versions of the application.

#### Installing and Running

+ Make sure you have rails installed: http://installrails.com/
+ Clone this repo
+ `cd todo-compare`
+ `bundle exec rake`  (run the specs)
+ `bundle exec foreman start`
+ visit localhost:5000

#### Playing Around

Once you are up and running try doing a small edit to the `todo.rb` component.  For example change the header from

```ruby
H1(class: 'ToDo-Header') { 'Hyperstack To Do' }
```
to
```ruby
H1(class: 'ToDo-Header') { 'My Hyperstack To Do App' }
```
you should instantly see your changes recompiled and reloaded on the app.

#### Other Branches

This git branch follows [Part I](https://medium.com/@mitch_23203/the-exact-same-app-in-hyperstack-7f281cef46ca) of the series.  If you `git checkout part-ii` or `git checkout part-iii` you can see the code additions for each of the following parts of the series.  (well once they are published anyway :-) )

#### Problems

If you have trouble put in an issue at [Stack Overflow](https://stackoverflow.com/questions/ask) and add the `hyperstack` tag.  
*Prefered method, as it is easy for others to search etc!*

Or visit us at https://gitter.im/ruby-hyperloop/chat.

Or add the issue here.

#### Hey Why Rails?

One of the powerful things about Hyperstack is that your database tables are automatically proxied to the client, and kept in sync.  To do this we need a database ORM which Rails provides via the ActiveRecord class.

Rails also provides also sorts of other backend goodies, such as mailers and queued tasks.

Finally even if your Hyperstack app is a very simple static application Rails provides an easy way to manage your component code.  Using Rails, Hyperstack will pre-render your component code, cache it, and deliver it with almost no runtime server interaction.

Yes Rails is big, but you only pay for the parts you use.
