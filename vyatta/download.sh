#!/bin/bash

set -e
set -u

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
VYATTA_DOCUMENT_URI=http://www.brocade.com/downloads/documents/html_product_manuals/vyatta/vyatta_5400_manual/wwhelp/books.htm
DOCSET_DOCUMENTS=$SCRIPT_DIR/vyatta.docset/Contents/Resources/Documents

wget -r -l 2 -L -p -nc -nv -R '.js' -P "$DOCSET_DOCUMENTS" "$VYATTA_DOCUMENT_URI"
