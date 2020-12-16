# Step 2 - It's a test framework, so it asserts!

Please make sure your are on step 2 in your terminal by typing:

```
bin/step 2
```

## Running a test against our own specification

In this second step we are going to test a simple `GET` endpoint.
Our API is currently serving a list of Todo items on `/todos`.

We start by creating a yaml file describing the specification of the endpoint. (Have a look at `todo-spec/todos/getAll.yml`).

Let's run webspicy:

```
webspicy --debug todo-spec/todos/getAll.yml
```

## Let's assert some more

We can improve our specification in two ways:

1. We can change the output schema from `Any` to a stricter schema. Let's ensure we receive an actual array of Todo items.

Edit the specification in `todo-spec/todos/getAll.yml` with your favorite editor and change the `output_schema` as follows:

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
webspicy --debug todo-spec/todos/getAll.yml
```

Try changing the assertions so that the test fails, and see what happens.
