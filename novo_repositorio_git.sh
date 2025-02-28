#!/bin/bash

echo "=== Configuração do Git para novo repositório ==="

# Nome fixo do usuário e do repositório (editar diretamente aqui antes de rodar)
GITHUB_USER="corry257"
REPO_NAME="ssh_git"

# Host SSH configurado no ~/.ssh/config
SSH_HOST="ssh_corry257"  
# a chave encontra-se no repositório /home/nome_do_seu_pc/.ssh/ Caso não tenha uma chave ssh leia a linha 87 do arquivo README.md em "Observações Importantes" 

# URL remota baseada no nome fixo
REMOTE_URL="git@github.com:$GITHUB_USER/$REPO_NAME.git"

echo -e "\n=== Resumo ==="
echo "Conta: $GITHUB_USER"
echo "Repositório: $REPO_NAME"
echo "URL Remota: $REMOTE_URL"

# Inicializa o repositório, se necessário
if [ ! -d ".git" ]; then
    echo "--- Inicializando o repositório Git ---"
    git init
else
    echo "--- Repositório já inicializado ---"
fi

# Configura ou ajusta o remote origin
CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null)

if [ "$CURRENT_REMOTE" == "$REMOTE_URL" ]; then
    echo "--- Remote origin já configurado corretamente ---"
else
    echo "--- Configurando ou atualizando remote origin ---"
    git remote remove origin 2>/dev/null
    git remote add origin "$REMOTE_URL"
fi

# Exibe os remotes configurados
echo "--- Remotes configurados ---"
git remote -v

# Tenta fazer pull para sincronizar (caso o repositório remoto já exista)
echo "--- Tentando fazer pull com rebase do repositório remoto ---"
git pull --rebase origin main || git pull --rebase origin master || echo "Nenhum branch remoto encontrado (ou repositório remoto vazio)."

# Verifica ou cria o branch main
CURRENT_BRANCH=$(git branch --show-current)

if [ -z "$CURRENT_BRANCH" ]; then
    echo "--- Nenhum branch encontrado, criando o branch main ---"
    git checkout -b main
else
    echo "--- Branch atual: $CURRENT_BRANCH ---"
fi

# Verifica status 
echo "--- Status do repositório ---"
git status

echo "--- Adicionando todos os arquivos ---"
git add .

# Verifica status novamente e faz o commit inicial
git status

echo "--- Criando primeiro commit ---"
git commit -m "Primeiro commit" || echo "Nenhuma modificação para commitar."

# Push inicial com set-upstream
echo "--- Enviando para o GitHub ---"
git push --set-upstream origin $(git branch --show-current)

echo "--- Configuração concluída! ---"
