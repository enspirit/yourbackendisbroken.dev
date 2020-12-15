# Webspicy Tutorial - Step 1

In this first step, we will show you that `webspicy` is a simple HTTP client, a bit like `curl`. The difference is that it allows making *assertions* about the content received from an API.

## Let's compare `curl` and `webspicy`

If you completed step 0, you should be able to reach our API example with curl:

```
$ curl http://127.0.0.1:3000/version
{"name":"TODOS API","version":"0.0.1"}
```

Let's now do the same using webspicy:

```
$ webspicy http://127.0.0.1:3000/version
```
