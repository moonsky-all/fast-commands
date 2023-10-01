# 快捷指令集

## 安装

```bash
./install.sh

# 若出现类似 `zsh: permission denied:` 的权限错误，可先执行: `chmod u+x *.sh` 命令授权后重新执行安装命令
```

#### 一、[pnpm](https://github.com/moonsky-all/fast-commands/blob/main/cmds/fast-pnpm.sh)
1. pn: `alias pn='pnpm'`
2. pnc: `alias pnc='pnpm create'`. 创建项目
3. pni: `alias pni='pnpm install'`. 安装依赖
4. pnit: `alias pnit='pnpm install-test'`. 安装依赖并测试
5. pns=`alias pns='pnpm start'`. 执行`package.json`的`start`命令, 相当于`pnpm run start`
6. pnb=`alias pnb='pnpm run build'`
7. pne=`alias pnb='pnpm env'`
8. pnt=`alias pnt='pnpm test'`
9. pna=`alias pna='pnpm add'`. 新增依赖
10. pnad=`alias pnad='pnpm add --save-dev'`. 新增开发依赖
11. pnap=`alias pnap='pnpm add --save-peer'`
12. pnao=`alias pnao='pnpm add --save-optional'`
13. pnaw=`alias pnaw='pnpm add --workspace'`. 新增`monorepo`根依赖
14. pnp=`alias pnp='pnpm patch'`
15. pnpc=`alias pnpc='pnpm patch-commit'`
16. pnpr=`alias pnpr='pnpm patch-remove'`
17. pnprm=`alias pnprm='pnpm patch-remove'`

#### 二、[git](https://github.com/moonsky-all/fast-commands/blob/main/cmds/fast-git.sh)
1. fcm: `git add . && git commit -am "$MESSAGE"`. 快速提交本地修改
2. fcmm: `alias='git commit --amend'`. 修改最近一次提交信息
3. fre: `git rebase -i HEAD~<$1>`. 合并最近 N 次`git commit`
4. fast: `git add . && git commit -m $1 && git push`. 快速提交本地修改并推送至远端仓库
5. fst: `git stash save`. 将目前修改保存到临时存储区
6. tsf: `git stash pop`. 应用最近一次临时存储区的修改，并从临时存储区移除记录
7. fst pop: `git stash pop`.
8. fst ls: `git stash list`.
9. fst ll: `git stash list`.

#### 三、[Directory](https://github.com/moonsky-all/fast-commands/blob/main/cmds/fast-directory.sh)
1. dir: `alias dir='open .'`. 在`Finder`打开当前命令行工作目录
2. dirrm: 从命令行当前工作目录开始递归删除指定名称的文件夹
3. noderm: `dirrm node_modules`. 递归删除`node_modules`目录, 这对前端开发比较有用, 尤其是`monorepo`多子项目管理时;
4. nodeclear: `dirrm node_modules`.
5. nodeclean: `dirrm node_modules`.
6. distrm: `dirrm dist`. 递归删除构建目录`dist`


## 说明
1. 此命令集中有一部分是多个相互具有逻辑关系的命令组成（如：`fst`, `tsf`, `dirrm`），所以使用时最好对原本的命令比较了解。
