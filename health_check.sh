#!/bin/bash
curl --fail --max-time 2 http://google.com
if [ $? -ne 0 ]; then
  kill 1
  exit 1
fi
exit 0