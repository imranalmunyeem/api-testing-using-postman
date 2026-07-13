# Sharing Your Work: Export and Import

The exported JSON file you will meet in this chapter is more than a sharing convenience — it is exactly what the command-line runners in Chapter 12 consume, which makes exporting the bridge between Postman-the-app and Postman-in-your-pipeline.

## Share a Collection from Postman

**Step 1** — Click on the **[…]** button beside your collection.

![Opening the actions menu next to the collection.](images/img-018-022.jpg)

**Step 2** — Click on **Share collection**.

**Step 3** — Choose how to share it — with specific people, via **Run in Postman**, or via a JSON link.

![Generating a shareable JSON link for the collection.](images/img-018-023.png)

**Step 4** — Anyone with access can import or fork the collection.

**Best practice:** with teammates, skip links entirely — move the collection into a shared **team workspace**. Everyone then works on the live collection with version history, forking, and pull-request-style merges, instead of emailing snapshots that immediately go stale. A JSON link is a static snapshot, and anyone holding it can read the collection — never link a collection containing credentials.

## Export a Collection as a File

**Step 1** — Click on the **[…]** button beside your collection, as before.

![The Export option in the collection menu.](images/img-019-024.jpg)

**Step 2** — Click on the **Export** button, choose **Collection v2.1 (recommended)**, and save the file to your local disk.

![Choosing the export format — Collection v2.1 is recommended.](images/img-020-025.png)

**A modern note:** Postman v12 introduced a newer **collection v3 (YAML)** format used by its Native Git workflows. Newman, the classic command-line runner, does not support v3 — only the Postman CLI does. For maximum compatibility with existing tooling, v2.1 JSON remains the safe default export today.

**Best practice — version the suite:** commit the exported collection (and sanitised environments) to the same Git repository as the code it tests, under a `collections/` folder. Tests then ride through code review, branch with features, and are available to every CI agent — the pattern Chapter 13 builds on.

## Export an Environment

In the same way, export the environment and save it alongside the collection.

![Exporting the environment from the environment's actions menu.](images/img-020-026.jpg)

![The Export option for the environment.](images/img-021-027.png)

**Security note:** an exported environment file contains its variable values in plain text. Before committing one to Git, strip tokens and passwords — or keep secrets in **current values** only (which are never exported) and inject real credentials in CI from the pipeline's secret store.

## Import a Collection

**Step 1** — Go to the **Collections** tab.

**Step 2** — Click on the **Import** button.

![The Import button at the top of the workspace sidebar.](images/img-022-028.png)

You can import from files, folders, links, or raw text — and not only Postman's own format: Postman imports **OpenAPI/Swagger definitions** (generating a full collection from the spec, a superb starting point for contract tests) and **cURL commands** copied from browser dev tools or documentation.

## Import an Environment

**Step 1** — Go to the **Environments** tab.

**Step 2** — Click on the **Import** button.

![The Environments tab with the Import button.](images/img-023-029.png)

**Step 3** — Locate the environment file you exported earlier. The importer can now run every request in the collection.
