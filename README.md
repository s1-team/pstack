# pstack

土豆姐 pstack skills 的备份，从 [cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack) 同步。技能在 `skills/<名称>/SKILL.md`。

安装：

```bash
npx skills@latest add s1-team/pstack
```

安装器会让你选 agent。已经知道目标时：

```bash
npx skills@latest add s1-team/pstack -a claude-code
npx skills@latest add s1-team/pstack -a codex
npx skills@latest add s1-team/pstack -a pi
```

更新已安装的技能用 `npx skills@latest update`。上游新增的技能要再跑一次 `add`。

`UPSTREAM` 是这次备份对应的 cursor/plugins 提交。`scripts/sync-pstack.sh` 用它和上游 `main` 比较，变了才复制。
