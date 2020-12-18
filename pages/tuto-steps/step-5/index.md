# Step 5 - Everybody loves Todos

Please make sure your are on step 5 in your terminal by typing:

```bash
bin/step 5
```

## Let's see how the API behaves on the creation of Todos

In `todo-spec/todos/post.yml` we can find the specification of the `POST /todos` endpoint.

As you can see we have included two counterexamples to ensure that the API is sanitizing its input data as prescribed by the pre & post conditions.

But is the API properly implemented?

Let's check:

```bash
webspicy --debug todo-spec/todos/post.yml
```

See how the two counterexamples tests have failed?
This is because the API didn't sanitize the input data and created two Todos with incorrect schemas.

You can see those two incorrect Todos if you call the `GET /todos` endpoint:

```bash
curl http://localhost:3000/todos
```

```output
[...,{"id":8,"foobar":42},{"id":9}]
```

Since these Todos do not respect the schemas, you'll also notice that our previous spec for `GET /todos` fails too:

```bash
webspicy --debug todo-spec/todos/getAll.yml
```

Have a go at trying to fix the API, or continue to the next step.
