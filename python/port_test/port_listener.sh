#!/bin/bash

while true; do

  nc -l -p 19132 | while read -r line; do



    echo "Hello from port 19132!"


  done
done
