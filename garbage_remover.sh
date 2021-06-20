#!/bin/bash

HELP=${1}

function usage() {
  echo "This script gonna search for files which you want to delete.
It gonna ask you in which folder look for them, expiration days and extensions of those files"
  exit 1
}

if [[ "${HELP}" =~ "-h" ]]; then
  usage
fi

echo "Do you want to delete garbage files?"
read -r INPUT

if [[ ${INPUT} != y ]] && [[ ${INPUT} != Y ]] && [[ ${INPUT} != yes ]]; then
  echo "Aborting operation"
  exit 0
fi

echo "Which folder do you want to check for garbage files?"
read -r DIRECTORY_INPUT

DIRECTORY_INPUT="/home/enrico/Code/bash/test_directory/"

if [[ ${DIRECTORY_INPUT} == "" ]] || [[ ${DIRECTORY_INPUT} == / ]]; then
  echo "No directory defined, aborting operation"
  exit 0
fi

echo "Searching in ${DIRECTORY_INPUT}"
echo ""
echo "In order to delete files, they have to be older than ... ? (in days)"
read -r DAYS_FOR_DELETION

if [[ ${DAYS_FOR_DELETION} == "" ]] || [[ ${DAYS_FOR_DELETION} == / ]]; then
  echo "No directory defined, aborting operation"
  exit 0
fi

echo "Which extension these files have? (e.g. .tmp)"
read -r type

readarray ARRAY_OF_FOUND_FILES < <(find "${DIRECTORY_INPUT}" -mtime +"${DAYS_FOR_DELETION}" -name '*.'"${type}")

if [[ "${#ARRAY_OF_FOUND_FILES[@]}" -eq 0 ]]; then
  echo "No files have been found in ${DIRECTORY_INPUT} older than ${DAYS_FOR_DELETION} of type ${type}"
  exit 1
fi

for i in "${ARRAY_OF_FOUND_FILES[@]}"; do
  rm -i $i
done
