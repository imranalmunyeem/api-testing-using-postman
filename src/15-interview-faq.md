# Interview FAQ

Thirty-seven questions that recur in API-testing interviews and code reviews, with answers reflecting current Postman behaviour. Use them as a self-test: read the question, answer aloud, then compare.

**1. What is Postman?**

Postman is an API platform for designing, building, testing, documenting, and iterating on APIs. Using Postman, we can send HTTP/HTTPS (and gRPC, GraphQL, WebSocket, and MQTT) requests to a service and inspect the responses to verify the service behaves as intended.

**2. Why Postman?**

It is free to start, with paid plans adding team features; it supports REST, SOAP, GraphQL, gRPC, and WebSocket calls; it is scriptable in JavaScript and extensible through the Postman API; it integrates with any CI/CD service through the Postman CLI or Newman; and its AI assistant, Postbot, can generate tests, fix scripts, and write documentation.

**3. What is an API?**

An Application Programming Interface is a contract that lets a client use a system's data or functionality: the client sends a request, the API receives it, the system retrieves or manipulates the appropriate data, and a response returns.

**4. What are the core components of an HTTP request?**

Five elements: the HTTP method (GET, POST, PUT, PATCH, DELETE); the URI describing the resource; the HTTP version; the request headers (for example `Content-Type: application/json`); and the payload — the request body carrying the message content.

**5. What are the core components of an HTTP response?**

Four elements: the status code (for example 404 Not Found, 200 OK); the HTTP version; the response headers (content type, length, date, server); and the response body containing the requested data.

**6. What are the HTTP response code classes?**

Five classes: informational (100–199), successful (200–299), redirection (300–399), client error (400–499), and server error (500–599). The full table is in Appendix A.

**7. Which status codes should a tester know cold?**

200 OK, 201 Created, 204 No Content; 301/302 redirects; 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 409 Conflict, 429 Too Many Requests; 500 Internal Server Error, 502 Bad Gateway, 503 Service Unavailable.

**8. What API information is exposed in browser developer tools?**

Request headers, the response body, and response cookies — everything in the Network tab.

**9. How do you bring a request from browser dev tools into Postman?**

**Copy as cURL** in the Network tab, then paste into Postman's import — it reconstructs the full request, headers and all.

**10. How does Basic authentication encode credentials?**

Basic auth encodes `username:password` in Base64 — a textual encoding (not encryption) that travels safely inside an HTTP header, which is why it is only acceptable over HTTPS. Postman generates it automatically when you choose Basic Auth in the Authorization tab; modern Postman also supports Bearer tokens, API keys, OAuth 2.0 with automatic token handling, JWT, AWS Signature, and more.

**11. Why Base64 rather than plain text?**

Base64 represents data using a fixed set of 64 characters that survive any HTTP header or form encoding. Remember it is trivially reversible — it provides transport safety, not secrecy.

**12. What is an environment in Postman?**

A named set of key–value pairs. Multiple environments — development, staging, production — can be switched instantly, running the same collection against each.

**13. Can global variables have duplicate names?**

No — globals exist outside any environment, so names are unique. Environment variables can share a name across different environments; indeed they should, since identical names with different values is what makes environment switching work.

**14. If a global and an environment variable share a name, which wins?**

The narrower scope. Postman's precedence, narrowest first: local > data > environment > collection > global.

**15. What is a Postman collection?**

A group of requests organised into folders — and the unit of automation: collections are what runners, monitors, mocks, and CI pipelines operate on.

**16. What are Postman monitors?**

Scheduled collection runs on Postman's cloud that alert you when tests fail — a regression suite converted into a continuous health check, with results shared by email or chat integrations.

**17. What is the collection runner used for?**

Executing a collection's requests in sequence, including data-driven testing — multiple iterations, each drawing variables from a row of a CSV or JSON data file — and, on paid plans, performance testing with simulated virtual users.

**18. Can local variables be used in monitors?**

Monitors use the environment attached to them; they do not see your local session state, and locally-scoped values are not carried over. Ensure every variable the collection needs has a synced value the monitor can read.

**19. Why use team workspaces in a company?**

A team workspace is a shared, access-controlled repository of collections and environments: work syncs instantly, everyone operates on the live version with history and forking, and permissions follow team roles.

**20. What should never be stored in synced Postman variables?**

Real credentials in **initial values** — initial values sync to Postman's servers and are visible to collaborators. Keep secrets in current values (local only), mark them with the *secret* type, use Postman Vault for the most sensitive, and in CI inject credentials from the pipeline's secret store.

**21. When do you use global, collection, and local variables?**

Globals for prototyping and passing data between requests quickly; collection variables for constants that travel with the suite (API versions, fixed IDs) and for values that must work without any environment; locals for values scoped to a single request or iteration, overriding everything else temporarily.

**22. How are local variables removed?**

Automatically, when the run finishes.

**23. How do you stop a collection run from a script?**

```javascript
pm.execution.setNextRequest(null);
```

The older `postman.setNextRequest(null)` still works; `pm.execution.setNextRequest` is the current API — and with a request name instead of `null`, it redirects the run's flow.

**24. What is the difference between form-data and x-www-form-urlencoded?**

`x-www-form-urlencoded` URL-encodes simple key–value text pairs; `form-data` uses multipart encoding and can carry files and binary content.

**25. Where are query parameters stored in a GET request?**

In the URL, after the `?` — for example `/users?page=2&limit=50`.

**26. How do you access a Postman variable?**

In URLs, headers, and bodies: `{{variableName}}`. In scripts: `pm.environment.get(...)`, `pm.collectionVariables.get(...)`, `pm.globals.get(...)`, or the scope-walking `pm.variables.get(...)`.

**27. What status code should a POST with invalid parameters return?**

**400 Bad Request** — and a useful error body. A 500 for bad input is itself a bug: the server failed to validate.

**28. How can you run a request 100 times?**

Set Iterations to 100 in the collection runner — or from the command line, `newman run collection.json -n 100`.

**29. How do you organise requests in Postman?**

With collections, and folders inside collections — ideally one folder per resource or feature, so folder-level scripts apply shared logic to the right group.

**30. Which language do Postman scripts use?**

JavaScript, executed in Postman's Node.js-based sandbox, with the Chai.js assertion library built in.

**31. What executes first in a collection run?**

Collection-level pre-request scripts, then folder-level, then request-level; after the response, post-response scripts run in the same collection → folder → request order.

**32. Which JavaScript libraries are available in Postman scripts?**

Lodash, Moment, Chai, cheerio, ajv (JSON-schema validation), crypto-js, uuid, and xml2js, among others — plus the Faker library behind dynamic variables like `{{$randomEmail}}`.

**33. Which tools run Postman collections in CI systems?**

Newman (the classic open-source runner) and the Postman CLI (the official successor, which can run collections directly from a workspace and report results back to Postman). Newman supports collection format v2/v2.1 only; the newer v3 format requires the Postman CLI.

**34. How do you log and inspect requests during debugging?**

The Postman Console shows every request exactly as sent — resolved variables, final headers — plus script `console.log` output. In CI, the runners print full logs, and reporters like htmlextra capture them in HTML reports.

**35. What is a GUID/UUID, and how does Postman generate one?**

A Globally Unique Identifier — hexadecimal digits separated by hyphens, designed never to collide. The dynamic variable `{{$guid}}` generates a fresh one per request, ideal for unique test data.

**36. What is Postbot?**

Postman's built-in AI assistant: it generates test scripts from natural-language prompts, creates test suites for whole collections, fixes failing scripts, writes API documentation, visualises response data, and answers Postman usage questions — all with awareness of the request you have open.

**37. Should AI-generated tests be trusted as-is?**

No. AI-generated tests validate the response the API currently gives, not the behaviour the specification demands — so they can enshrine bugs as expected results. Review generated assertions against requirements, keep negative tests deliberate, and never include secrets in prompts.
