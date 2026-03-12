#!/usr/bin/env zsh
# uninstall.sh — Claude Profiles
# Remove as funções do ~/.zshrc (não apaga credenciais do Keychain)

ZSHRC="$HOME/.zshrc"
MARKER_START="# >>> claude-profiles"
MARKER_END="# <<< claude-profiles"

if ! grep -q "$MARKER_START" "$ZSHRC" 2>/dev/null; then
  echo "claude-profiles não encontrado em $ZSHRC. Nada a remover."
  exit 0
fi

# Remove o bloco entre os markers (inclusive)
sed -i '' "/$MARKER_START/,/$MARKER_END/d" "$ZSHRC"

echo "Removido do $ZSHRC."
echo ""
echo "As credenciais no Keychain NÃO foram apagadas."
echo "Para removê-las manualmente:"
echo "  security delete-generic-password -s 'Claude Code-credentials-pessoal' -a \"\$USER\""
echo "  security delete-generic-password -s 'Claude Code-credentials-enterprise' -a \"\$USER\""
