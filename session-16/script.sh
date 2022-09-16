az storage blob service-properties update \
   --account-name "mbidzinskistorageaccount" \
   --static-website \
   --404-document "error.html" \
   --index-document "index.html" \
   --verbose \
   -o table