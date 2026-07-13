#!/usr/bin/env bash
# Build EPUB and PDF from the Markdown source. Requires pandoc; PDF additionally requires XeLaTeX.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist

CHAPTERS=(
  src/00-about-this-book.md
  src/part-1-foundations.md
  src/01-understanding-apis-and-api-testing.md
  src/02-getting-started-with-postman.md
  src/part-2-postman-essentials.md
  src/03-collections-and-requests.md
  src/04-sending-requests-and-reading-responses.md
  src/part-3-writing-tests.md
  src/05-your-first-tests.md
  src/06-variables-and-environments.md
  src/07-advanced-scripting.md
  src/08-designing-a-test-strategy.md
  src/part-4-collaboration-and-scale.md
  src/09-sharing-your-work-export-and-import.md
  src/10-running-collections-at-scale.md
  src/11-mock-servers-and-monitors.md
  src/part-5-automation-and-ci-cd.md
  src/12-the-command-line-newman-and-the-postman-cli.md
  src/13-continuous-integration-jenkins-and-github-actions.md
  src/part-6-the-ai-era.md
  src/14-ai-assisted-api-testing.md
  src/part-7-reference.md
  src/15-interview-faq.md
  src/appendix-a-http-status-codes.md
  src/glossary.md
  src/about-the-author.md
)

echo "Building EPUB..."
pandoc metadata.yaml "${CHAPTERS[@]}" \
  -o dist/API-Testing-Using-Postman.epub \
  --resource-path=src --toc --toc-depth=2 \
  --epub-cover-image=cover.jpg --css=epub.css \
  --split-level=1 -f markdown+implicit_figures

echo "Building PDF..."
pandoc metadata.yaml "${CHAPTERS[@]}" \
  -o dist/API-Testing-Using-Postman.pdf \
  --resource-path=src --toc --toc-depth=2 \
  --pdf-engine=xelatex \
  -V documentclass=report -V fontsize=11pt \
  -V geometry:margin=2.5cm -V papersize=a4 \
  -V mainfont="DejaVu Serif" -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" \
  -V linkcolor=NavyBlue -V urlcolor=NavyBlue \
  -f markdown+implicit_figures

echo "Done: dist/"
