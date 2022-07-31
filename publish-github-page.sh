#!/usr/bin/env bash
set -e

cd $(dirname "$0")

if [ "$(git status --porcelain)" != "" ]; then
  echo "ERROR: open changes in git"
fi

git checkout -B page
rm -rf docs/ dist/
npm run build -- --sourcemap true --minify false
mv dist docs

git add docs/
git commit -m "npm run build; mv dist docs"
git checkout -
git push origin page --force-with-lease

echo "Reach out: https://sealor.github.io/github-commit-graph/"
