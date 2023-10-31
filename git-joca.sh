#!/bin/bash

# Mostra todos os comandos disponíveis
function joca-help() {
  echo "Comandos disponíveis:"
  echo "  joca feature start <nome>"
  echo "  joca feature finish <nome>"
}

function joca-command-not-found() {
  echo "Erro: Comando ($1) não encontrado"
}

function joca-feature() {
  # Verifica se foram passados pelo menos 2 parâmetros
  if [ $# -lt 2 ]; then
    echo "Erro: o comando 'feature' precisa de 2 parâmetros"
    exit 1
  fi

  # Argumentos
  local command=$1
  local name=$2

  # Verifica qual comando foi executado
  case "$command" in
    "start")
      joca-feature-start $name
      ;;
    "finish")
      joca-feature-finish $name
      ;;
    *)
      joca-command-not-found $command
      ;;
  esac
}

# Cria uma nova feature branch
function joca-feature-start() {
  # Argumentos
  local nome=$1

  # Executa os comandos
  git fetch origin
  git switch --detach origin/main
  git checkout -b $nome
}

# Termina uma feature branch
function joca-feature-finish() {
  # Argumentos
  local nome=$1

  # Executa os comandos
  git checkout $nome
  git fetch origin
  git rebase origin/main
  git push -u origin $nome
}

case "$1" in
  "feature")
    joca-feature $2 $3
    ;;
  *)
    joca-help
    ;;
esac