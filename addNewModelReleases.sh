#!/bin/sh

git status --porcelain releases | grep -F '?? releases/B' | cut -c 4-|xargs git add
git status --porcelain releases | grep -F '?? releases/0' | cut -c 4-|xargs git add
