# Step 3 - It ensures robustness too

Please make sure your are on step 3 in your terminal by typing:

```bash
bin/step 3
```

## Testing the robustness against an non existent TODO

In `todo-spec/todos/getOne.yml` we can find the specification of the `GET /todos/{id}` endpoint.

Let's see if the API is robust (spoiler: it's not).

As with the `examples` section, `webspicy` supports a `counterexamples` section. Let's add one:

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

And let's run webspicy (the ROBUST environment variable is used here to execute counterexamples only):

```bash
ROBUST=only webspicy --debug todo-spec/todos/getOne.yml
```

The test fails: the API returns an empty body with a 200 status code. You can check this by looking at the debug info that was displayed in your terminal:

```output
~> GET http://127.0.0.1:3000/todos/9999
    Req params: {
    }
    Req headers: {
    }
  .
    Res status: 200 OK
    Res headers: {
      "X-Powered-By": "Express",
      "Date": "Fri, 18 Dec 2020 09:34:08 GMT",
      "Connection": "close",
      "Content-Length": "0"
    }
    Res body:
```

Feel like fixing the API for us before you move on? Edit `todo-api/src/index.js`.
