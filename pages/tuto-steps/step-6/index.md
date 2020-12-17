# Step 6 - Test isolation (who said social distancing?)

Please make sure your are on step 6 in your terminal by typing:

```bash
bin/step 6
```

## Application state & blackbox testing

For proper blackbox testing it's important to ensure that the tests we are running can safely make assumptions about the application state.

Remember our spec for `GET /todos` ?

We were expecting the list of todos to have a size of 6.
That is because the API, when it starts, creates a list of todos (in memory for now) pre-populated with 6 todos.

But now that we have finished our webspicy spec for `POST /todos` that list will change.

Let's do the following: let's test our `GET /todos` then the `POST /todos` and then the `GET /todos again`.

```
webspicy todo-spec/todos/getAll.yml
# it works
webspicy todo-spec/todos/post.yml
# it works
webspicy todo-spec/todos/getAll.yml
# it now fails
```

The `GET /todos` test fails because we were expecting 6 todos, but we now have 7.

Webspicy allows you to configure hooks that are run before, after & around tests. Here will simply use such a hook to reset the application state before each test.

Make sure your todo-spec/config.rb contains the following, and re-run the tests like here above.

```rb
Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://127.0.0.1:3000"
  c.client = Webspicy::HttpClient

  c.before_each do
    Kernel.system 'curl -X POST http://localhost:3000/reset'
  end
end
```
