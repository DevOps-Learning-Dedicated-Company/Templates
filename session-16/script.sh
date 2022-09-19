#!/bin/bash
az storage blob service-properties update \
   --account-name "armconforstaticweb" \
   --static-website \
   --404-document "404.html" \
   --index-document "index.html" \
   --verbose \
   -o table
