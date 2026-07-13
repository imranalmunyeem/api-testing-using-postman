# Designing a Test Strategy

Tools execute tests; testers *choose* them. Given an endpoint, what should you actually verify? This chapter is the checklist and the reasoning behind it — the difference between a suite that looks busy and a suite that catches bugs.

## The Layered Checklist

For every endpoint that matters, work outside-in through five layers:

**1. Protocol layer.** The right status code for the right situation — 200/201/204 on success, and *specific* failures: 400 for malformed input, 401 for missing credentials, 403 for insufficient rights, 404 for absent resources. The correct `Content-Type`. Sensible response time.

**2. Contract layer.** The response matches its schema: required fields present, types correct, formats valid (dates parse, emails contain @, IDs are the declared type). This is Chapter 7's schema validation, applied everywhere consumers depend on structure.

**3. Data layer.** The *values* are right: the created user has the name you sent; the filtered list contains only matching records; the total equals the sum of the parts; pagination returns page 2, not page 1 again.

**4. Behaviour layer.** State actually changed: after DELETE, a GET returns 404; after PATCH, only the patched fields differ; POSTing the same order twice does not charge twice. These require chained requests — and they are where the most expensive bugs live.

**5. Security layer.** Every negative auth case from Chapter 4: no token, expired token, wrong user's token, insufficient role. Plus: error responses that don't leak stack traces or internal hostnames.

## Positive, Negative, and Boundary

For each input an endpoint accepts, generate cases along three axes:

- **Positive** — valid, typical input succeeds (the case everyone writes).
- **Negative** — invalid input fails *correctly*: missing required fields, wrong types, malformed JSON, unknown IDs, illegal state transitions. The assertion is not merely "it fails" but "it fails with the right status and a useful error body." APIs that return 500 for bad input have a bug even though they rejected the request.
- **Boundary** — the edges: empty strings, zero, negative numbers, maximum lengths, page sizes of 0 and 1 and the documented limit and the limit plus one, Unicode in text fields.

A practical heuristic: for a typical endpoint, expect one or two positive cases and *five to ten* negative and boundary cases. If your suite is mostly green-path, it is mostly decorative.

## Prioritising: You Cannot Test Everything First

Order the work by risk: start with the endpoints whose failure costs most (auth, payment, anything that writes data), then the ones that change most often, then the rest. A ten-test suite on the login endpoint beats a hundred tests on a static reference lookup.

**Best practice — the regression contract:** every bug found in production earns a permanent test reproducing it. Over a year, this single habit builds the most valuable suite you will own, because it is provably aligned with real failure modes.

## Keeping the Suite Honest

Three disciplines keep a growing suite trustworthy:

- **Deterministic tests.** A test that sometimes fails without a code change is worse than no test — it trains the team to ignore red. Hunt flakiness down: usually shared state, missing teardown, or time-dependent assertions.
- **Independent tests where possible.** Chained workflows are necessary, but keep chains short and self-contained within a folder; a suite where request 40 depends on request 3 is unmaintainable.
- **Readable failures.** Name tests so a red line states the defect: "PATCH ignores read-only fields" tells the developer everything before they open Postman.

With a strategy in hand and a suite taking shape, the next problems are human and operational: sharing the work with a team, and running it at scale.
