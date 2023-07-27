#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e
# npx browserslist@latest --update-db -y
# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github pages
echo 'wiki.liunanfang.com' > CNAME

cat CNAME

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:Say-healer/Say-healer.github.io.git
else
  Date=`date '+%Y%m%d%H%M%S'`
  echo $Date
  msg='GitHub Actions Deploy'
  githubUrl=https://Say-healer:${GITHUB_TOKEN}@github.com/Say-healer/Say-healer.github.io.git
  git config --global user.name "Say-healer"
  git config --global user.email "lnf0991@163.com"
fi

git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github gh-pages分支
#   npx browserslist@latest --update-db