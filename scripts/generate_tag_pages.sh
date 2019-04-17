#!/usr/bin/env bash
rm -rf tags/
TAGS=$(grep --exclude-dir=examples -R -h 'tags: \[' | sed 's/tags: \[//; s/\]//; s/, /\n/g' | sort -u)
mkdir tags
for TAG in $TAGS; do
	mkdir tags/"$TAG"
	cat <<- EOF > tags/"$TAG"/index.md
	---
	title: "Tag: $TAG"
	layout: tag
	tag: $TAG
	---
	EOF
done
