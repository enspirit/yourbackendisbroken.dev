# Step 7 - Generated counterexamples

Please make sure your are on step 7 in your terminal by typing:

```bash
bin/step 7
```

## Isn't creating robustness tests exhausting?

Yes.

You may think that a good framework covers your back. Maybe it has support for input sanitization, automatic 404 responses, and so on. That might relieve you of having to write counterexample tests, right?

Not exactly. Counterexamples fit in two categories:

* Counterexamples that check conformance to generic PRE-conditions: input sanitization, error routes and schema, and so on.

* Counterexamples that check conformance to domain-specific PRE-conditions: authentication, invalid state, etc.

Let's see what `webspicy` proposes for them.

## Generated counterexamples for generic preconditions

The last commit changed the `config.rb` file to install a reusable `RobustToInvalidInput` precondition. Preconditions in `webspicy` can automatically generate `counterexamples` by mutating existing `examples` to make them violate the PRE-conditions.

In practice, this gives you generated robustness tests for free. Try this:

```bash
ROBUST=generated webspicy tuto-steps
```

## Your own generated counterexamples

Having generated counterexamples for generic situations help you focussing on the real counterexamples that you need to write: *those that are specific to your business*.

Indeed some PRE-conditions may apply to many web services: think of authentication for instance. Instead of writing counterexamples for them in each specification, you can write your own precondition that will generate counterexamples for each of them.
