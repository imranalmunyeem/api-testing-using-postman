# Glossary

**API (Application Programming Interface)** — the contract letting one piece of software use another; in this book, almost always a web API spoken over HTTP.

**Assertion** — a single checked expectation inside a test, such as `pm.expect(status).to.eql(200)`.

**Base64** — a reversible textual encoding using 64 characters; used by Basic auth, it provides transport safety, not secrecy.

**Chai.js** — the assertion library built into Postman's script sandbox, providing the readable `expect(...).to...` syntax.

**CI/CD (Continuous Integration / Continuous Delivery)** — the practice of automatically building and testing every code change, and keeping software releasable at all times.

**Collection** — Postman's grouping of requests into a runnable, shareable, documentable unit; the test suite's container.

**Collection Runner** — the engine that executes a collection's requests and tests in sequence, manually, on a schedule, or via CLI.

**Contract testing** — verifying that a response's structure (fields, types, formats) matches an agreed schema, protecting the API's consumers.

**Data-driven testing** — running the same requests once per row of a data file, with `{{column}}` variables resolved from each row.

**Endpoint** — a specific URL (plus method) exposed by an API, such as `GET /users/42`.

**Environment** — a named set of Postman variables representing one deployment target (staging, production) and switchable in one click.

**Flaky test** — a test that sometimes fails without any code change; the most corrosive defect a suite can have.

**Idempotent** — an operation that produces the same result however many times it is repeated; GET, PUT, and DELETE are meant to be idempotent, POST typically is not.

**JSON (JavaScript Object Notation)** — the human-readable data format of modern APIs: nested objects, arrays, strings, numbers, booleans.

**JWT (JSON Web Token)** — a signed token format widely used for API authentication, carried in the `Authorization: Bearer` header.

**Mock server** — a Postman-hosted URL that serves your saved response examples, letting consumers and tests work before (or without) the real API.

**Monitor** — a scheduled cloud run of a collection with alerting; a regression suite on patrol.

**Newman** — the classic open-source command-line runner for Postman collections (v2/v2.1 format), famed for its htmlextra HTML reports.

**OAuth 2.0** — the standard delegated-authorisation framework; Postman can drive its token flows automatically.

**OpenAPI (Swagger)** — the standard machine-readable format for describing REST APIs; importable into Postman as a ready-made collection.

**Payload** — the body of a request or response; the data being carried.

**Postbot** — Postman's built-in AI assistant for generating tests, fixing scripts, documenting, and visualising.

**Postman CLI** — the official command-line runner, able to run collections directly from a workspace and report results to Postman's cloud; required for the v3 collection format.

**Pre-request script** — JavaScript that runs before a request is sent (Scripts → Pre-request); the home of setup logic.

**Post-response script** — JavaScript that runs after the response arrives (Scripts → Post-response); the home of tests.

**Regression testing** — re-running existing tests to confirm that what worked yesterday still works today.

**REST (Representational State Transfer)** — the dominant architectural style for web APIs: resources at URLs, manipulated with standard HTTP methods.

**Schema validation** — asserting that a JSON body conforms to a JSON Schema; Postman ships the ajv validator for this.

**Status code** — the three-digit result summary of every HTTP response; see Appendix A.

**Test pyramid** — the strategy model placing many fast unit tests at the base, API/service tests in the middle, and few end-to-end UI tests at the top.

**Variable scope** — the level at which a Postman variable lives; precedence, narrowest first: local > data > environment > collection > global.

**Workspace** — Postman's top-level container for collections, environments, mocks, and monitors; personal, private, team, or public.
