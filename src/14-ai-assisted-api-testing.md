# AI-Assisted API Testing

## Postbot: Postman's AI Assistant

Postbot is Postman's built-in AI assistant, available from the Postman footer. It understands the context of whatever you have open — the request, its response, your scripts — and acts on plain-English instructions. Its most useful skills for a tester:

**Generate tests.** Open a request, send it once so a response exists, open **Scripts → Post-response**, and invoke Postbot. Ask in natural language:

> *"Add tests for the status code, the content type, and that the response time is under 500 ms."*

> *"Verify the response body has a `token` field and save it as a collection variable."*

> *"Add a test that validates the response against its JSON schema."*

Postbot writes the JavaScript directly into your script editor, using the same `pm.test` / `pm.expect` patterns from Chapter 5 — which is exactly why you learnt them by hand: so you can read, review, and correct what the AI writes.

**Generate a whole test suite.** From a collection's **[…]** menu, choose **Generate tests**, and Postbot adds baseline tests — status, content type, response time, structure — to every request in the collection at once. For a large collection, hours of boilerplate become minutes of review.

**Fix a failing script.** When a test script throws an error, Postbot offers a **Fix script** action — it analyses the error, proposes a correction, and applies it on your approval. When a request itself fails, asking *"What's wrong?"* gets a context-aware diagnosis.

**Document and visualise.** Postbot can write documentation for a request or collection from its actual traffic, and can turn a JSON response into a table or chart on demand — genuinely useful when exploring an unfamiliar API.

**Availability note:** Postbot's packaging has changed over time — it began as a general feature and is now positioned as an add-on, with enterprise plans adding privacy guarantees (inputs not used for model training). Check your plan's current terms; you can also disable Postbot entirely in settings if your organisation requires it.

## Beyond Postbot: the Wider AI Toolkit

**AI requests.** Postman can send requests directly to AI model providers — and to any OpenAI-compatible endpoint, including self-hosted and local models — via a dedicated AI request type. If your product exposes an LLM-backed API, you can test it with the same collections, environments, and scripts as any other endpoint. (Testing AI endpoints adds a twist worth knowing: responses are non-deterministic, so assertions shift from exact values to properties — structure, length bounds, required fields, forbidden content.)

**Agent Mode and MCP.** Postman's Agent Mode takes multi-step actions on your behalf — building collections, running them, analysing results, even raising Jira or GitHub issues with context attached. Through Postman's MCP server, external AI agents can be given structured access to your APIs, so an AI coding assistant can run a collection or generate client code that matches how your API actually behaves.

**General-purpose AI assistants.** Outside Postman, LLM assistants are now routine companions for testers: generating edge-case ideas from an OpenAPI specification, drafting a CSV of boundary values for a data-driven run, explaining an unfamiliar auth flow, or converting a cURL command into a collection request. Treat them as a fast junior colleague — enormously productive, occasionally confidently wrong.

## Keeping Judgement in the Loop

AI-generated tests inherit a specific weakness: they validate what the response *is*, not what it *should be*. If your API wrongly returns `200` for an invalid payload, an AI generating tests from the observed response will happily assert that the bug is correct behaviour — enshrining the defect as the expected result. So:

- **Review every generated assertion** against the specification or requirement, not the current response.
- **Keep negative tests deliberate.** AI suggestions skew towards happy paths; wrong passwords, missing fields, expired tokens, and malformed bodies still need a human's adversarial instinct — the Chapter 8 checklist does not automate away.
- **Never paste secrets into prompts.** Tokens, customer data, and internal URLs do not belong in any AI conversation unless your plan contractually protects them.
- **Own the suite.** A test you cannot read is a test you cannot trust. Everything in Chapter 5 exists precisely so that AI accelerates your understanding rather than replacing it.

Used this way, AI does for test authoring what Newman did for test execution: it removes the drudgery and leaves you the judgement. That division of labour — machines for repetition, humans for meaning — has been the story of this book from the first assertion to the last pipeline, and it is the safest prediction about whatever comes next.
