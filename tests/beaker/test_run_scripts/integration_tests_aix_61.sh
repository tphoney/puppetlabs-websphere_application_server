#!/bin/bash

# Init
SCRIPT_PATH=$(pwd)
BASENAME_CMD="basename ${SCRIPT_PATH}"
SCRIPT_BASE_PATH=`eval ${BASENAME_CMD}`

if [ $SCRIPT_BASE_PATH = "test_run_scripts" ]; then
  cd ../../../
fi

export pe_dist_dir="http://pe-releases.puppetlabs.lan/2015.3.3"
export GEM_SOURCE=https://artifactory.delivery.puppetlabs.net/artifactory/api/gems/rubygems/

bundle install --without build development test --path .bundle/gems

bundle exec beaker \
  --preserve-host \
  --repo-proxy \
  --host tests/beaker/configs/aix-61.yml \
  --debug \
  --pre-suite tests/beaker/pre-suite \
  --tests tests/beaker/tests \
  --keyfile ~/.ssh/id_rsa-acceptance \
  --load-path tests/beaker/lib
