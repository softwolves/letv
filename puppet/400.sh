#!/bin/bash
awk  '($2 ~/400/)' /usr/local/letv/access_201212061200.log  >/tmp/400
