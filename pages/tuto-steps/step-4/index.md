# Step 4 - Let's step back a moment

Please make sure your are on step 4 in your terminal by typing:

```
bin/step 4
```

## Summary of earlier steps

In Step 2 and Step 3 we saw that we can call web services
and assert some properties on both the response headers and output.
Step 2 contributed a test *example* and Step 3, a *counterexample*.

The last commit fixes the API to be meet it's specification. We can
now execute the entire test suite and see that it now passes:

```
webspicy todo-spec
```

## Examples and POST-conditions ; counterexamples and PRE-conditions

In both steps we added a test case and some assertions but
there is a major difference between them:

- The example added in Step 2 tests a 'happy path'. The
  test checks that *when everything is ok (with the input)*
  (and if the web service is correctly implemented) then
  the *result meets the specification*, which is tested
  through all assertions.

- The counterexample added in Step 3 is a robustness test.
  It checks that *if something is wrong (with the input)*
  (and if the web service is correctly implemented) then
  it detects the situation and *guarantees exceptional
  behavior anyway* instead of failing hard in an unspecified
  way.

Those notions relate to the notion of PRE- and POST- conditions:

- The *PRE-conditions* are all conditions to be met to have the
  web service succeeding when called.

- The *POST-conditions* are all conditions guaranteed on the result
  (by a correct implementation).

With these definitions:

- A webspicy example is a test that checks the *POST-conditions* are
  met if the *PRE-conditions* are as well.

- A counterexample is a test that checks that some exceptional *POST-conditions*
  are met if the *PRE-conditions* are violated.

## An explicit specification

`webspicy` supports explicit `preconditions` and `postconditions`. We
will use them in an informal way here, and see later that they can be
used to leverage test coverage by generating tests automatically.

Writing a more complete specification for `GET /todo/{id}` would look
like this.

```yaml
...
services:
- method: |-
    GET

  description: |-
    Returns the specified todo

  preconditions: |-
    - The input must meet the `input_schema`
    - The input `id` must correspond to an existing TODO

  postconditions: |-
    - If PRE are met, the output meets the `output_schema`
    - If PRE are met, the HTTP response meets the `expectations`
  #
    - If PRE are not met (or an error occurs), the output meets the `error_schema`
    - If the input `id` does not correspond to a TODO, a 404 is returned

  input_schema: |-
    Todo.Ref
  output_schema: |-
    Todo.Full
  error_schema: |-
    String

  examples:
  - description: |-
      it succeeds when the todo exists
    params:
      id: 2
    expected:
      content_type: application/json
      status: 200
    assert:
      - equals('description', 'two')"

  counterexamples:
  - description: |-
      it fails with a 404 when no such todo
    params:
      id: 9999
    expected:
      content_type: text/plain
      status: 404
    assert:
      - match(/Not Found/)
```

In practice, we generally keep conditions about schema and response
expectations implicit, and only write domain-specific *PRE* and
*POST* conditions related to the system state.

Also, writing all tests required to cover the specification may
quickly become a daunting task.

We will come back to those points later. For now, let's apply our
recent learning to the creation of TODO items.
