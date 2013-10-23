#!/bin/sh

git status releases | grep -F '#       releases/B' | cut -c 9-|xargs git add
