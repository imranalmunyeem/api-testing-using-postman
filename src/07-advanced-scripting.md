# Advanced Scripting

One request that checks itself is a test; several requests that cooperate are a *workflow*. This chapter adds the scripting techniques that turn a pile of requests into realistic end-to-end scenarios: pre-request scripts, passing data between requests, dynamic test data, schema validation, and shared logic at folder and collection level.

## Pre-request Scripts

Everything in **Scripts → Pre-request** runs *before* the request is sent — the natural home for setup: computing a timestamp, generating a signature, fetching a fresh token, or logging state for debugging.

```javascript
// Give every run a unique correlation id
pm.environment.set("runId", pm.variables.replaceIn("{{$guid}}"));

// Log what we're about to do (appears in the Postman Console)
console.log("Creating user with runId", pm.environment.get("runId"));
```

The **Postman Console** (footer, or View → Show Postman Console) is your debugger: it shows every request as actually sent — resolved variables, final headers — plus everything you `console.log`. When a variable "mysteriously" doesn't resolve, the Console ends the mystery in seconds.

## Chaining Requests: the Create-then-Verify Pattern

Real scenarios span requests: create a resource, capture its ID, then read, update, and delete it. The bridge is a variable set in one request's post-response script and used in the next request's URL.

In the **POST /users** post-response script:

```javascript
pm.test("User created", () => pm.response.to.have.status(201));

const created = pm.response.json();
pm.collectionVariables.set("newUserId", created.id);
```

The next request's URL becomes `{{baseUrl}}/users/{{newUserId}}`, with its own tests:

```javascript
pm.test("Created user is retrievable", () => {
    pm.response.to.have.status(200);
    pm.expect(pm.response.json().id)
        .to.eql(pm.collectionVariables.get("newUserId"));
});
```

Run the collection (Chapter 10) and the whole life cycle executes in order — a genuine integration test.

**Controlling the flow:** by default the runner executes requests top to bottom. Scripts can redirect it:

```javascript
// Jump to a named request
pm.execution.setNextRequest("Delete user");

// Or stop the run entirely
pm.execution.setNextRequest(null);
```

(The older `postman.setNextRequest(...)` still works; `pm.execution.setNextRequest` is the current API.) Use flow control sparingly — a suite that jumps around is hard to read — but it is invaluable for skip-on-failure logic and polling loops.

## Dynamic Test Data

Postman bundles the Faker library as *dynamic variables*, resolvable anywhere with `{{$...}}`:

- `{{$guid}}` — a unique identifier
- `{{$timestamp}}` — current Unix time
- `{{$randomEmail}}`, `{{$randomFullName}}`, `{{$randomInt}}` — realistic random data

A POST body like `{"email": "{{$randomEmail}}"}` gives every run fresh, collision-free data — which is what lets the same suite run repeatedly against a persistent staging database without tripping over its own leftovers.

**Best practice:** tests that create data should delete it. A teardown request at the end of a workflow folder keeps staging clean and keeps your suite re-runnable — the cardinal virtue of automation.

## Schema Validation: Contract Testing in Ten Lines

Field-by-field assertions catch value bugs; *schema* validation catches structural drift — a renamed field, a number that became a string, a missing property — which is exactly what breaks API consumers. Postman ships the **ajv** JSON-schema validator via Chai's `jsonSchema` matcher:

```javascript
const userSchema = {
    type: "object",
    required: ["id", "name", "email"],
    properties: {
        id:    { type: "integer" },
        name:  { type: "string" },
        email: { type: "string", pattern: "@" }
    }
};

pm.test("Response matches the user schema", () => {
    pm.expect(pm.response.json()[0]).to.be.jsonSchema(userSchema);
});
```

Store shared schemas in a collection variable (as a JSON string) and `JSON.parse` them in tests, and every endpoint returning a user validates against the *same* contract.

## Sharing Logic: Collection and Folder Scripts

Scripts don't only belong to requests. A **collection-level** post-response script runs after *every* request in the collection — the perfect home for universal assertions:

```javascript
pm.test("No server errors", () => {
    pm.expect(pm.response.code).to.be.below(500);
});
```

Folder-level scripts do the same for a folder's requests. Execution order is collection → folder → request for pre-request scripts, and the same order again for post-response scripts. Shared assertions written once at the top level are the single cheapest coverage upgrade available in Postman.

Your toolbox is now complete. The remaining question — the most important one — is what to point it at.
