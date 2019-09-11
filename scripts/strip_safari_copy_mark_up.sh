#!/bin/bash
#Clear the stuff in angle brackets from the clip board

PB=$(pbpaste)
OUT=$(echo "${PB}" | sed -e 's/<[^>]*>//g')
echo "${OUT}"
echo "${OUT}" | pbcopy
