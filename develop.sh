#!/bin/bash

echo -e "\n\033[0;32mStarting Hugo development server...\033[0m\n"

myip=`curl https://ipinfo.io/ip`

hugo server \
  --baseURL="http://$myip" \
  --bind=0.0.0.0 \
  --buildDrafts \
  --disableFastRender \
  --verbose

