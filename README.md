# Claude Profiles

Switch between multiple Claude Code accounts on macOS without logging out and back in every time.

Credentials are stored securely in the **Mac Keychain** — nothing saved in plain text.

> **Requirement:** macOS with Claude Code installed.

---

## Installation

```bash
git clone https://github.com/seu-usuario/claude-profiles.git
cd claude-profiles
chmod +x install.sh uninstall.sh
./install.sh
source ~/.zshrc
```

---

## Initial Setup

You need to save each profile once. Follow the steps below:

### 1. Save the profile you are currently logged into

If you are already logged in with one account (e.g. enterprise), save it now:

```bash
claude-salvar-enterprise
```

### 2. Save the second profile

Open Claude Code and use `/logout` to sign out:

```bash
claude   # open Claude Code
# inside Claude Code, type:
/logout
# exit with /exit, then in the shell:
claude   # opens again and asks for login
# log in with your personal account, exit with /exit
claude-salvar-pessoal
```

> **Note:** never run `claude logout` in the shell — it does not exist. Logout is done
> with `/logout` inside Claude Code.

---

## Usage

```bash
claude-pessoal        # activate personal profile
claude-enterprise     # activate enterprise profile
claude-perfil-ativo   # show which profile is active
```

After activating a profile, open Claude Code normally:

```bash
claude
```

---

## How it works

Claude Code stores authentication credentials in the Mac Keychain under the key `Claude Code-credentials`.

This project creates named copies of those credentials:

| Keychain key | Description |
|---|---|
| `Claude Code-credentials` | Active credential (read by Claude Code) |
| `Claude Code-credentials-pessoal` | Saved personal profile |
| `Claude Code-credentials-enterprise` | Saved enterprise profile |

Running `claude-pessoal` or `claude-enterprise` copies the corresponding credential into `Claude Code-credentials`, which is what Claude Code reads on startup.

---

## Skill for Claude Code (optional)

To let Claude Code understand profile commands and answer questions like *"which account am I using?"*, copy the skill to the skills folder:

```bash
mkdir -p ~/.claude/skills/claude-profiles
cp skill/SKILL.md ~/.claude/skills/claude-profiles/SKILL.md
```

After that, you can ask Claude Code things like:
- *"Which profile am I using?"*
- *"How do I switch accounts?"*

---

## Uninstall

```bash
./uninstall.sh
source ~/.zshrc
```

Credentials saved in the Keychain are **not removed** automatically. To delete them:

```bash
security delete-generic-password -s "Claude Code-credentials-pessoal" -a "$USER"
security delete-generic-password -s "Claude Code-credentials-enterprise" -a "$USER"
# Remove legacy email entries if they exist
security delete-generic-password -s "Claude Code-email-pessoal" -a "$USER" 2>/dev/null
security delete-generic-password -s "Claude Code-email-enterprise" -a "$USER" 2>/dev/null
```

---

## Project structure

```
claude-profiles/
├── functions.zsh     # shell functions (sourced by .zshrc)
├── install.sh        # adds functions to .zshrc
├── uninstall.sh      # removes functions from .zshrc
├── skill/
│   └── SKILL.md      # optional skill for Claude Code
└── README.md
```

---

## License

MIT
