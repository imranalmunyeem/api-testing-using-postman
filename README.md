# API Testing Using Postman

**The practical guide to modern API testing — from your first request to AI-assisted CI/CD pipelines.**

By [Imran Al Munyeem](https://imranalmunyeem.com)

[![Licence: CC BY-NC-SA 4.0](https://img.shields.io/badge/Licence-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![Read Online](https://img.shields.io/badge/Read-Online-yellow.svg)](https://imranalmunyeem.github.io/api-testing-using-postman/)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)

---

A free, open, screenshot-driven book that takes you from an empty Postman install to a fully automated API test suite running in CI/CD — with a solid grounding in HTTP, a professional test-design strategy, and a clear-eyed chapter on putting AI assistants to work without surrendering your judgement.

## Who this book is for

QA engineers moving into API testing, developers who want their APIs properly tested, students preparing for testing interviews, and anyone who has clicked **Send** in Postman and wondered what a *professional* would do next.

## What you will learn

- **Foundations** — APIs, REST, and the anatomy of every HTTP request and response, read the way a tester reads them
- **Postman essentials** — workspaces, collections, requests, responses, and authentication done right
- **Writing tests** — JavaScript assertions with Chai, variables and environments, request chaining, schema validation, and how to *design* a test strategy rather than just accumulate tests
- **Scale** — sharing and versioning suites, data-driven and scheduled runs, mock servers, and monitors
- **Automation** — Newman and the Postman CLI, Jenkins, and GitHub Actions, with secrets handled properly
- **The AI era** — Postbot, AI-assisted test generation, and the judgement-in-the-loop discipline that keeps it safe
- **Reference** — a 37-question interview FAQ, the full HTTP status code table, and a glossary

## Read the book

| Format | Where |
|---|---|
| **Online (HTML)** | https://imranalmunyeem.github.io/api-testing-using-postman/ |
| **PDF** | [Latest release](../../releases/latest) · [Zenodo (citable, DOI)](https://doi.org/10.5281/zenodo.XXXXXXX) |
| **EPUB (Kindle & e-readers)** | [Latest release](../../releases/latest) |
| **Source (Markdown)** | [`src/`](src/) |

## Table of contents

**Part I — Foundations:** Understanding APIs and API Testing · Getting Started with Postman
**Part II — Postman Essentials:** Collections and Requests · Sending Requests and Reading Responses
**Part III — Writing Tests:** Your First Tests · Variables and Environments · Advanced Scripting · Designing a Test Strategy
**Part IV — Collaboration and Scale:** Sharing Your Work · Running Collections at Scale · Mock Servers and Monitors
**Part V — Automation and CI/CD:** Newman and the Postman CLI · Jenkins and GitHub Actions
**Part VI — The AI Era:** AI-Assisted API Testing
**Part VII — Reference:** Interview FAQ · HTTP Status Codes · Glossary

## Build the book yourself

The book is plain Markdown in [`src/`](src/). To render it:

**Website (mdBook):**

```bash
cargo install mdbook      # or download a binary from the mdBook releases page
mdbook serve              # live preview at http://localhost:3000
mdbook build              # static site in ./book
```

**EPUB and PDF (pandoc):**

```bash
./build.sh                # produces dist/API-Testing-Using-Postman.epub and .pdf
```

## Contributing

Found an error, an outdated screenshot, or a technique worth adding? Issues and pull requests are very welcome — this book improves the way test suites do: one reviewed change at a time. Please open an issue first for anything larger than a typo fix.

## Citing this book

If this book is useful in your research, teaching, or writing, please cite it (see [`CITATION.cff`](CITATION.cff), or use the **Cite this repository** button on GitHub):

> Munyeem, I. A. (2026). *API Testing Using Postman: The Practical Guide to Modern API Testing*. Zenodo. https://doi.org/10.5281/zenodo.XXXXXXX

## Licence

Text and images © Imran Al Munyeem, released under [CC BY-NC-SA 4.0](LICENSE.md) — share and adapt freely for non-commercial purposes, with attribution, under the same licence. Code samples in the book are additionally released under the MIT Licence so you can use them in any project without restriction.

## About the author

Imran Al Munyeem is a PhD researcher in Computer Science at Nottingham Trent University, specialising in cybersecurity, hybrid cyber range architectures, and AI-assisted security testing, with several years of industry experience in test automation and API testing. More at [imranalmunyeem.com](https://imranalmunyeem.com).
