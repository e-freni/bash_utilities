#!/bin/bash

HELP=${1}

function usage() {
    echo "This script gonna search inside a folder for file extensions and gonna rearrange them into specific folders"
    exit 1
}

if [[ "${HELP}" =~ "-h" ]]; then
    usage
fi

echo "Do you want to rearrange files?"
read -r INPUT

if [[ ${INPUT} != y ]] && [[ ${INPUT} != Y ]] && [[ ${INPUT} != yes ]]; then
    echo "Aborting operation"
    exit 0
fi

echo "Which folder do you want to check for garbage files?"
read -r DIRECTORY_INPUT

ARRAY_OF_FOUND_FILES=("${DIRECTORY_INPUT}"/*)

for i in "${ARRAY_OF_FOUND_FILES[@]}"; do
    echo "$i"
    case "$i" in
    *.doc | *.docx | *.txt | *.pdf)
        FOLDER="docs"
        ;;
    *.jpg | *.jpeg | *.png)
        FOLDER="pictures"
        ;;
    *.sh)
        FOLDER="scripts"
        ;;
    *.war | *.jar)
        FOLDER="java"
        ;;
    *.zip | *.tar | *.tar.gz | *.tar.gz.bz2)
        FOLDER="archives"
        ;;
    *.ppt | *.pptx)
        FOLDER="powerpoints"
        ;;
    *.mp3)
        FOLDER="audios"
        ;;
    *.mp4)
        FOLDER="videos"
        ;;
    *.xls | *.xlsx)
        FOLDER="sheets"
        ;;
    *)
        FOLDER="."
        ;;
    esac

    if [ ! -d "$DIRECTORY_INPUT/$FOLDER" ]; then
        mkdir "$DIRECTORY_INPUT/$FOLDER"
    fi

    mv "$i" "$DIRECTORY_INPUT/$FOLDER" 2>/dev/null
done
