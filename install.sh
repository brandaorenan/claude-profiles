#!/usr/bin/env zsh
# install.sh — Claude Profiles
# Adiciona as funções de troca de perfil no ~/.zshrc

set -e

ZSHRC="$HOME/.zshrc"
MARKER="# >>> claude-profiles"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Verifica se já está instalado
if grep -q "$MARKER" "$ZSHRC" 2>/dev/null; then
  echo "claude-profiles já está instalado em $ZSHRC"
  echo "Para reinstalar, rode primeiro: ./uninstall.sh"
  exit 0
fi

# Adiciona source no .zshrc
echo "" >> "$ZSHRC"
echo "$MARKER" >> "$ZSHRC"
echo "source \"$SCRIPT_DIR/functions.zsh\"" >> "$ZSHRC"
echo "# <<< claude-profiles" >> "$ZSHRC"

echo "Instalado com sucesso!"
echo ""
echo "Recarregue o shell:"
echo "  source ~/.zshrc"
echo ""
echo "Próximos passos:"
echo "  1. Faça login com cada conta via: claude"
echo "  2. Salve cada perfil:"
echo "       claude-salvar-pessoal"
echo "       claude-salvar-enterprise"
echo "  3. Use os comandos para alternar:"
echo "       claude-pessoal"
echo "       claude-enterprise"
echo "       claude-perfil-ativo"
