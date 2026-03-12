# Claude Profiles

Troca entre múltiplas contas do Claude Code no macOS sem precisar fazer logout/login toda vez.

As credenciais ficam seguras no **Keychain do Mac** — nada é salvo em texto plano.

> **Requisito:** macOS com Claude Code instalado.

---

## Instalação

```bash
git clone https://github.com/seu-usuario/claude-profiles.git
cd claude-profiles
chmod +x install.sh uninstall.sh
./install.sh
source ~/.zshrc
```

---

## Configuração inicial

Você precisa salvar cada perfil uma vez. Faça isso na ordem abaixo:

### 1. Salvar o perfil que já está logado

Se você já está logado com uma conta (enterprise, por exemplo), salve agora:

```bash
claude-salvar-enterprise
```

### 2. Salvar o segundo perfil

Abra o Claude Code e use `/logout` para sair da conta atual:

```bash
claude   # abre o Claude Code
# dentro do Claude Code, digite:
/logout
# saia com /exit, depois no shell:
claude   # abre de novo e pede login
# faça login com a conta pessoal, saia com /exit
claude-salvar-pessoal
```

> **Dica:** nunca rode `claude logout` no shell — isso não existe. O logout é feito
> com `/logout` dentro do Claude Code.

---

## Uso

```bash
claude-pessoal        # ativa conta pessoal
claude-enterprise     # ativa conta enterprise
claude-perfil-ativo   # mostra qual está ativo
```

Depois de ativar um perfil, abra o Claude Code normalmente:

```bash
claude
```

---

## Como funciona

O Claude Code armazena as credenciais de autenticação no Keychain do Mac com a chave `Claude Code-credentials`.

Este projeto cria cópias nomeadas dessas credenciais:

| Chave no Keychain | Descrição |
|---|---|
| `Claude Code-credentials` | Credencial ativa (lida pelo Claude Code) |
| `Claude Code-credentials-pessoal` | Cópia do perfil pessoal |
| `Claude Code-credentials-enterprise` | Cópia do perfil enterprise |

Ao rodar `claude-pessoal` ou `claude-enterprise`, o script copia a credencial correspondente para `Claude Code-credentials`, que é o que o Claude Code lê ao iniciar.

---

## Skill para Claude Code (opcional)

Para que o próprio Claude Code entenda os comandos de perfil e possa responder perguntas como *"qual conta estou usando?"*, copie a skill para a pasta de skills:

```bash
mkdir -p ~/.claude/skills/claude-profiles
cp skill/SKILL.md ~/.claude/skills/claude-profiles/SKILL.md
```

Depois disso, você pode perguntar ao Claude Code coisas como:
- *"Qual perfil estou usando?"*
- *"Como troco de conta?"*

---

## Desinstalação

```bash
./uninstall.sh
source ~/.zshrc
```

As credenciais salvas no Keychain **não são apagadas** automaticamente. Para removê-las:

```bash
security delete-generic-password -s "Claude Code-credentials-pessoal" -a "$USER"
security delete-generic-password -s "Claude Code-credentials-enterprise" -a "$USER"
```

---

## Estrutura do projeto

```
claude-profiles/
├── functions.zsh     # funções de shell (source pelo .zshrc)
├── install.sh        # adiciona as funções ao .zshrc
├── uninstall.sh      # remove as funções do .zshrc
├── skill/
│   └── SKILL.md      # skill opcional para o Claude Code
└── README.md
```

---

## Licença

MIT
