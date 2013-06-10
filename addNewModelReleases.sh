#!/bin/sh

svn stat releases | grep '^?'|cut -c 9-|xargs svn add
