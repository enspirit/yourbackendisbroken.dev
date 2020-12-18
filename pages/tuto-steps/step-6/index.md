# Step 6 - Test isolation (who said social distancing?)

Please make sure your are on step 6 in your terminal by typing:

```bash
bin/step 6
```

## A test suite integration problem

Remember our specification for `GET /todos` ?

We were expecting the list of todos to have a size of 6. That is because the API, when it starts, creates a list of todos (in memory for now) pre-populated with 6 todos.

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

## Blackbox testing & Application state

Functional blackbox testing requires some control over the application state. Indeed the PRE and POST-conditions, as well as all assertions, are about the system state reached after the web service has been executed in a known initial state.

There are different ways to control the initial state using `webspicy`, but we will cover only one here: hooks.

Webspicy allows you to configure hooks that are run before, after & around tests. Here we will simply use such a hook to reset the application state before each test.

In this tutorial, we added a `/reset` webservice for that specific purpose. Make sure your todo-spec/config.rb contains the following, and re-run the tests like here above.

```rb
Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://127.0.0.1:3000"
  c.client = Webspicy::HttpClient

  c.before_each do
    Kernel.system 'curl -X POST http://localhost:3000/reset'
  end
end
```

> Don't introduce a `/reset` web service on real software systems since it could introduce a security issue if it reaches production. The best is to invest in your DevOps architecture so that the application state can be managed easily in development and test environments without exposing anything in production.

Once changed, re-run the tests above, or check that the entire test suite passes multiple times in a row:

```
webspicy todo-step
```
