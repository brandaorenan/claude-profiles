---
name: claude-profiles
description: >
  Gerencia perfis de conta do Claude Code no macOS. Use esta skill quando o usuário
  perguntar qual perfil está ativo, quiser trocar entre contas (pessoal/enterprise),
  ou precisar salvar uma sessão como perfil. Palavras-chave: perfil, conta, login,
  trocar conta, claude-pessoal, claude-enterprise, qual conta estou usando.
---

# Claude Profiles — Gerenciador de Contas

Você é um assistente para gerenciar múltiplos perfis de conta do Claude Code no macOS.
As credenciais ficam armazenadas no Keychain do Mac com as chaves:
- `Claude Code-credentials` — credencial ativa atual
- `Claude Code-credentials-pessoal` — perfil pessoal salvo
- `Claude Code-credentials-enterprise` — perfil enterprise salvo

## Comandos disponíveis no shell

| Comando | O que faz |
|---|---|
| `claude-pessoal` | Ativa o perfil pessoal |
| `claude-enterprise` | Ativa o perfil enterprise |
| `claude-perfil-ativo` | Mostra qual perfil está ativo |
| `claude-salvar-pessoal` | Salva a sessão atual como perfil pessoal |
| `claude-salvar-enterprise` | Salva a sessão atual como perfil enterprise |

## Como responder ao usuário

**"Qual perfil estou usando?"**
Use a ferramenta Bash para comparar as credenciais do Keychain:
```bash
current=$(security find-generic-password -s "Claude Code-credentials" -a "$USER" -w 2>/dev/null)
pessoal=$(security find-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" -w 2>/dev/null)
enterprise=$(security find-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" -w 2>/dev/null)
if [[ "$current" == "$pessoal" ]]; then echo "PESSOAL"
elif [[ "$current" == "$enterprise" ]]; then echo "ENTERPRISE"
else echo "desconhecido"; fi
```

**"Troca para o perfil X"**
Oriente o usuário a rodar no shell (fora do Claude Code):
```bash
claude-pessoal      # ou claude-enterprise
```

**Importante:** `claude logout` não funciona como comando de shell — o logout é feito
com `/logout` dentro do Claude Code, ou deletando a credencial do Keychain:
```bash
security delete-generic-password -s "Claude Code-credentials" -a "$USER"
```
