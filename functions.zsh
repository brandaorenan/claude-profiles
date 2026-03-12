# ─── Claude Code: múltiplos perfis ───────────────────────────────────────────
# Requer macOS (usa o Keychain via comando `security`)
# Instale com: ./install.sh

claude-salvar-pessoal() {
  local pw
  pw=$(security find-generic-password -s "Claude Code-credentials" -a "$USER" -w 2>/dev/null)
  if [[ -z "$pw" ]]; then
    echo "Nenhuma credencial ativa encontrada no Keychain."
    return 1
  fi
  security delete-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" &>/dev/null
  security add-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" -w "$pw"
  echo "Perfil pessoal salvo no Keychain."
}

claude-salvar-enterprise() {
  local pw
  pw=$(security find-generic-password -s "Claude Code-credentials" -a "$USER" -w 2>/dev/null)
  if [[ -z "$pw" ]]; then
    echo "Nenhuma credencial ativa encontrada no Keychain."
    return 1
  fi
  security delete-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" &>/dev/null
  security add-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" -w "$pw"
  echo "Perfil enterprise salvo no Keychain."
}

claude-pessoal() {
  local pw
  pw=$(security find-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" -w 2>/dev/null)
  if [[ -z "$pw" ]]; then
    echo "Perfil pessoal não encontrado. Execute claude-salvar-pessoal primeiro."
    return 1
  fi
  security delete-generic-password -s "Claude Code-credentials" -a "$USER" &>/dev/null
  security add-generic-password -s "Claude Code-credentials" -a "$USER" -w "$pw"
  echo "Perfil pessoal ativado."
}

claude-enterprise() {
  local pw
  pw=$(security find-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" -w 2>/dev/null)
  if [[ -z "$pw" ]]; then
    echo "Perfil enterprise não encontrado. Execute claude-salvar-enterprise primeiro."
    return 1
  fi
  security delete-generic-password -s "Claude Code-credentials" -a "$USER" &>/dev/null
  security add-generic-password -s "Claude Code-credentials" -a "$USER" -w "$pw"
  echo "Perfil enterprise ativado."
}

claude-perfil-ativo() {
  local current pessoal enterprise
  current=$(security find-generic-password -s "Claude Code-credentials" -a "$USER" -w 2>/dev/null)
  pessoal=$(security find-generic-password -s "Claude Code-credentials-pessoal" -a "$USER" -w 2>/dev/null)
  enterprise=$(security find-generic-password -s "Claude Code-credentials-enterprise" -a "$USER" -w 2>/dev/null)

  if [[ -z "$current" ]]; then
    echo "Nenhuma credencial ativa. Rode: claude-pessoal ou claude-enterprise"
  elif [[ "$current" == "$pessoal" ]]; then
    echo "Perfil ativo: PESSOAL"
  elif [[ "$current" == "$enterprise" ]]; then
    echo "Perfil ativo: ENTERPRISE"
  else
    echo "Perfil ativo: desconhecido (não corresponde a nenhum perfil salvo)"
  fi
}
