#!/bin/bash

set -e
set -u

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
DOCSET_DOCUMENTS=$SCRIPT_DIR/vyatta.docset/Contents/Resources/Documents
DOCSET_DATABASE=$SCRIPT_DIR/vyatta.docset/Contents/Resources/docSet.dsidx

cp Info.plist "$SCRIPT_DIR/vyatta.docset/Contents"
bundle exec ruby "$SCRIPT_DIR/generate.rb" "$DOCSET_DOCUMENTS" "$DOCSET_DATABASE"
