#!/usr/bin/env bash

mkdir -p $HOME/.gem
touch $HOME/.gem/credentials
chmod 0600 $HOME/.gem/credentials
printf -- "---\n:rubygems_api_key: Bearer ${RUBYGEMS_API_KEY}\n" > $HOME/.gem/credentials
gem build *.gemspec
gem push *.gem
