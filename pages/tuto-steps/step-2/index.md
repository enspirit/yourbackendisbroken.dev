# Step 2 - It's a test framework, so it asserts!

In this second step we are going to test a simple `GET` endpoint.
Our API is currently serving a list of Todo items on `/todos`.

We start by creating a yaml file describing the specification of the endpoint. (Have a look at `todo-spec/todos/getAll.yml`).

Let's run webspicy:

```
webspicy todo-spec/todos/getAll.yml
```

## Let's assert some more

We can improve our specification in two ways:

1. We can change the output schema from `Any` to a stricter schema. Let's ensure we receive an actual array of Todo items.

```yaml
output_schema: |-
  [{
    id: Integer
    description: String
  }]
```

2. To ensure we receive 6 Todo items, assert some properties onto the output as shown below:

```yaml
...
expected:
  content_type: application/json
  status: 200
assert:
  - size(6)
...
```

Let's run webspicy again:

```
webspicy todo-spec/todos/getAll.yml
```
