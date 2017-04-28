#!/bin/sh
kill $(ps aux | grep sockd | grep -v grep | awk '{print $2}')