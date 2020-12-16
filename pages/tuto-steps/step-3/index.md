# Webspicy Tutorial - Step 3

In `todo-spec/todos/getOne.yml` we can find the specification of the `GET /todos/:id` endpoint.

Let's see if the API is robust.

As with the `examples` section, webspicy supports a `counterexamples` section.

Let's add one:

```yaml
counterexamples:

  - description: |-
      when requesting a non existent todo
    params:
      id: 9999
    expected:
      content_type: text/plain
      status: 404
```

And let's run webspicy:

```
webspicy todo-spec/todos/getOne.yml
```

Feel like fixing the API for us before you move on? Edit `todo-api/src/index.js`.
