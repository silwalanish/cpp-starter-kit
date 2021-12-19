#!/bin/sh

usage="$(basename "$0") [-h] [-n name] [-p path] -- create a cpp project

where:
    -h  show this help text
    -n  name of the project
    -p  path to create the project"

help()
{
  echo "$usage"
}

PROJECT_PATH="."

while getopts ':hn:p:' option; do
  case "$option" in
    h) help
       exit
       ;;
    n) PROJECT_NAME=$OPTARG
       ;;
    p) PROJECT_PATH=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       help >&2
       exit 1
       ;;
    \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       help >&2
       exit 1
       ;;
  esac
done

if ((OPTIND == 1))
then
  echo "No options specified."
  help
  exit 1
fi

if [ -z "$PROJECT_NAME" ]; then
  echo "Project Name is required."
  help
  exit 1
fi

echo "Making sure directory ${PROJECT_PATH} is empty..."
mkdir -p $PROJECT_PATH
if [ "$(ls -A $PROJECT_PATH)" ]; then
  echo "$PROJECT_PATH is not empty".
  exit
fi

echo "Changing directory to ${PROJECT_PATH}..."
cd $PROJECT_PATH

echo "Cloning cpp-starter-kit to ${PROJECT_PATH}..."
git clone --depth=1 https://github.com/silwalanish/cpp-starter-kit.git .

echo "Setting up the project..."
rm -rf .git
rm create-cpp-project.sh
git init

# Replace Name in ProjectInfo.mk
sed -i "s/cpp-starter-kit/$PROJECT_NAME/" ProjectInfo.mk
sed -i "2 s/:=.*/:= $PROJECT_NAME/" ProjectInfo.mk

# Create a README.md file
sed -i "s/cpp-starter-kit/$PROJECT_NAME/" README.md
sed -i "2 s/.*/$PROJECT_NAME/" README.md
start_line=$(awk '/# Features/{ print NR; exit }' README.md)
end_line="$(($(awk '/## `setup`/{ print NR; exit }' README.md) - 1))"
sed_cmd="${start_line},${end_line}d"
sed -i $sed_cmd README.md

start_line=$(awk '/# Project Structure/{ print NR; exit }' README.md)
sed_cmd="${start_line},\$d"
sed -i $sed_cmd README.md
