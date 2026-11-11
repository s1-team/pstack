# pstack

从 [cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack) 同步的 pstack skills。仓库根的 `skills/` 下面每个目录是一个技能，入口是 `SKILL.md`。Claude Code、Codex 和 Pi 都读这一层。

`UPSTREAM` 记录这次内容对应的 cursor/plugins 提交。`scripts/sync-pstack.sh` 拿它和上游 `main` 比较，有变化才复制，并把 `.claude-plugin/plugin.json` 的 `version` 写成该提交的前 12 位。Claude Code 和 Codex 只在这个版本变化时更新已安装的插件。

插件是只读订阅。`npx skills` 会把文件复制进项目，方便修改。两条路选一条，一起装会得到两份相同技能。

## Claude Code

```bash
claude plugin marketplace add s1-team/pstack
claude plugin install pstack@s1-team
```

## Codex

```bash
codex plugin marketplace add s1-team/pstack
codex plugin add pstack@s1-team
```

## Pi

```bash
pi install git:github.com/s1-team/pstack
```

之后用 `pi update --extensions` 拉到最新的 `main`。

## 复制到项目里

```bash
npx skills@latest add s1-team/pstack -a claude-code
npx skills@latest add s1-team/pstack -a codex
npx skills@latest add s1-team/pstack -a pi
```

不写 `-a` 时，安装器会列出它认识的 agent。更新已复制的技能用 `npx skills@latest update`；上游新增的技能要再跑一次 `add`。
