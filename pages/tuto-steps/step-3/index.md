# Step 3 - It ensures robustness too

Please make sure your are on step 3 in your terminal by typing:

```bash
bin/step 3
```

## Testing the robustness against a unexisting TODO

In `todo-spec/todos/getOne.yml` we can find the specification of the `GET /todos/{id}` endpoint.

Let's see if the API is robust.

As with the `examples` section, `webspicy` supports a `counterexamples` section.

Let's add one:

```yaml
counterexamples:

  - description: |-
      it fails with a 404 for non existent todo
    params:
      id: 9999
    expected:
      content_type: text/plain
      status: 404
    assert:
      - match(/Not Found/)
```

And let's run webspicy:

```bash
webspicy --debug todo-spec/todos/getOne.yml
```

Feel like fixing the API for us before you move on? Edit `todo-api/src/index.js`.
