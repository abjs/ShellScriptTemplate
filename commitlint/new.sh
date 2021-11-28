#!/bin/bash
if [ $# -eq 0 ]
then
    echo "Enter Project Folder Name"
    exit 1
fi
mkdir  $1
cd $1
npm  init -y
file=package.json
sed -i 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"commit": "cz","prepare": "husky install","release": "standard-version"/g' "$file"
sed -i 's/"version": "1.0.0"/"version": "0.0.0"/g' "$file"
sed -i 's/"author": ""/"author": "Abin Joseph"/g' "$file"
echo '{
        "extends" : ["@commitlint/config-conventional"]
}' > .commitlintrc.json
echo '{
    "path": "cz-conventional-changelog"
}' > .czrc
git init
pnpm install -D commitizen @commitlint/config-conventional @commitlint/cli husky cz-conventional-changelog standard-version
npx husky install
npx husky add .husky/commit-msg "npx commitlint --edit"
npx gitignore node
git add .
git commit --allow-empty -m "feat: project setup" -m "setup new project with husky conventional commit standard-version"
prettier "*" --write --ignore-unknown