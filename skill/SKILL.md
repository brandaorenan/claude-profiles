---
name: claude-profiles
description: >
  Manages Claude Code account profiles on macOS. Use this skill when the user
  asks which profile is active, wants to switch between accounts (personal/enterprise),
  or needs to save a session as a profile. Keywords: profile, account, login,
  switch account, claude-pessoal, claude-enterprise, which account am I using.
---

# Claude Profiles — Account Manager

You are an assistant for managing multiple Claude Code account profiles on macOS.
Credentials are stored in the Mac Keychain under the following keys:
- `Claude Code-credentials` — current active credential
- `Claude Code-credentials-pessoal` — saved personal profile
- `Claude Code-credentials-enterprise` — saved enterprise profile

## Available shell commands

| Command | What it does |
|---|---|
| `claude-pessoal` | Activates the personal profile |
| `claude-enterprise` | Activates the enterprise profile |
| `claude-perfil-ativo` | Shows which profile is currently active |
| `claude-salvar-pessoal` | Saves the current session as the personal profile |
| `claude-salvar-enterprise` | Saves the current session as the enterprise profile |

## How to respond to the user

**"Which profile am I using?"**
Use the Bash tool to compare Keychain credentials:
```bash
current=$(security find-generic-password -s "Claude Code-credentials" -a "$USER" -w 2>/dev/null)
pessoal=$(security find-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" -w 2>/dev/null)
enterprise=$(security find-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" -w 2>/dev/null)
if [[ "$current" == "$pessoal" ]]; then echo "PERSONAL"
elif [[ "$current" == "$enterprise" ]]; then echo "ENTERPRISE"
else echo "unknown"; fi
```

**"Switch to profile X"**
Tell the user to run in the shell (outside Claude Code):
```bash
claude-pessoal      # or claude-enterprise
```

**Important:** `claude logout` does not work as a shell command — logout is done
with `/logout` inside Claude Code, or by deleting the credential from the Keychain:
```bash
security delete-generic-password -s "Claude Code-credentials" -a "$USER"
```
