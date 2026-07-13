# Mock Servers and Monitors

Two Postman features extend your collection beyond testing: mocks let work start before the API exists, and monitors keep watch after it ships. Both are built from assets you already have.

## Mock Servers: Test Before the API Exists

A **mock server** serves the *examples* saved on your requests (Chapter 3) from a real URL that Postman hosts. Create one from the workspace sidebar (**New → Mock Server**), attach it to your collection, and Postman gives you a URL; any request to it returns the matching saved example.

Why testers care:

- **Unblock front-end work** — the UI team codes against realistic responses weeks before the backend lands.
- **Test your own tests** — point the suite at a mock that returns known-good and known-bad examples and verify your assertions catch what they should.
- **Simulate the awkward cases** — save examples for 500s, timeouts, and malformed bodies that are hard to trigger on demand against a real service.

Treat the mock as part of the contract: when the real API's schema changes, update the examples the same day, or the mock becomes a source of false confidence.

## Monitors: Your Suite on Patrol

A **monitor** runs a collection on a schedule from Postman's cloud and alerts you (by email, or into Slack and similar via integrations) when tests fail — effectively your regression suite converted into a production health check. Create one from **New → Monitor**, pick the collection, an environment, and a frequency.

Monitors use the environment you attach to them — they do not see your local session state — so double-check that every variable the collection needs has a synced value the monitor can read (which is also a reason monitor environments must never rely on secrets stored only in current values; use a dedicated, least-privilege monitoring credential instead).

**Best practice:** monitor a *small, fast, read-only* subset of your suite — a health-check folder — rather than the full regression pack. You want a pager signal, not a nightly data-modifying crawl over production.
