# Step 1 - Webspicy is a bit like `curl`

Please make sure your are on step 1 in your terminal by typing:

```bash
bin/step 1
```

## Let's compare `curl` and `webspicy`

In this first step, we will show you that `webspicy` is a simple HTTP client, a bit like `curl`. The difference is that it allows making *assertions* about the content received from an API.

If you completed step 0, you should be able to reach our API example with curl:

```bash
curl http://127.0.0.1:3000/version
```

```stdout
{"name":"TODOS API","version":"0.0.1"}
```

Let's now do the same using webspicy:

```bash
webspicy http://127.0.0.1:3000/version
```

```stdout
GET http://127.0.0.1:3000/version it returns a 200
  meets its specification

Finished in 0.00779 seconds (files took 0.01864 seconds to load)
1 example, 0 failures
```

## `webspicy` is a specification & test framework

While curl calls the web service and shows the *output*,
`webspicy` takes it as an API test that succeeds if it returns
a 200 status code.

That's because `webspicy` is a *test* framework, that checks
whether a web service meets a *specification*. Here it used
a default specification that you can see with the `--debug`
flag:

```bash
webspicy --debug http://127.0.0.1:3000/version
```

```yaml
---
name: |-
  Default specification
url: |-
  http://127.0.0.1:3000/version

services:
- method: |-
    GET
  description: |-
    Getting http://127.0.0.1:3000/version

  input_schema: |-
    Any
  output_schema: |-
    Any
  error_schema: |-
    Any

  examples:
    - description: |-
        it returns a 200
      params: {}
      expected:
        status: 200
```

We will write our own specifications in next steps!
