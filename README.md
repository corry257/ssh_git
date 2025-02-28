# Gerando e Configurando uma Nova Chave SSH para o GitHub no Linux

Este tutorial ensina como gerar uma nova chave SSH para vincular ao GitHub em sistemas Linux e como configurar o arquivo `config` dentro da pasta `.ssh` para facilitar o uso com scripts e conexões.

---

## 1. Verificar Chaves Existentes

Antes de criar uma nova chave, é recomendado verificar se você já tem alguma chave SSH configurada.

```bash
ls -la ~/.ssh
```
Se existirem arquivos como id_rsa, id_rsa.pub ou config, significa que você já tem alguma configuração anterior.

## 2. Criar uma Nova Chave SSH
Execute o comando abaixo para gerar uma nova chave SSH.

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"
```
*Opção -t ed25519: Cria uma chave moderna e mais segura.*
*Opção -C: Adiciona um comentário à chave, geralmente o seu e-mail.*  

Durante a geração:  
Escolha o diretório e o nome do arquivo (exemplo: ~/.ssh/id_github).  
Pode deixar a senha de proteção em branco ou definir uma (opcional).

## 3. Adicionar a Chave SSH ao Agente SSH
Certifique-se de que o ssh-agent está rodando.

```bash
eval "$(ssh-agent -s)"
```  

Adicione a chave criada ao agente.

```bash
ssh-add ~/.ssh/id_github
```

## 4. Criar ou Atualizar o Arquivo Config
Crie ou edite o arquivo ~/.ssh/config para associar a nova chave SSH ao GitHub.

```bash
nano ~/.ssh/config
```
Exemplo de configuração:

        # Chave ssh do github
        Host github.com
          HostName github.com
          User git
          IdentityFile ~/.ssh/id_github
          IdentitiesOnly yes

*Host github.com: Define uma configuração específica para conexões com o GitHub.*  
*HostName: Define o host real.*  
*User: Define o usuário SSH (sempre git para o GitHub).*  
*IdentityFile: Aponta para o arquivo da chave recém-criada.*  
*IdentitiesOnly yes: Garante que apenas a chave definida será usada.*  

Salve (CTRL+O e ENTER) e saia (CTRL+X).

## 5. Copiar a Chave Pública
Para vincular ao GitHub, copie o conteúdo da chave pública.

```bash
cat ~/.ssh/id_github.pub
```

Copie todo o conteúdo exibido no terminal.

## 6. Adicionar a Chave Pública no GitHub
Acesse https://github.com/settings/keys.
Clique em New SSH Key.
No campo Title, insira um nome identificador (ex: "Chave Linux Pessoal").
No campo Key, cole a chave pública copiada.
Clique em Add SSH Key.

## 7. Testar Conexão com o GitHub
Execute o comando abaixo para confirmar se a configuração está correta.

bash
ssh -T git@github.com

Se tudo estiver certo, você verá uma mensagem como:

        Hi seu-usuario! You've successfully authenticated, but GitHub does not provide shell access.

## 8. Configuração Final para Scripts
O arquivo ~/.ssh/config é fundamental para que scripts e comandos git automáticos utilizem a chave correta. Certifique-se de que cada chave associada a um serviço diferente tenha uma entrada no arquivo config.  

Exemplo de arquivo com múltiplas chaves:

        Host github.com
            HostName github.com
            User git
            IdentityFile ~/.ssh/id_github
            IdentitiesOnly yes

        Host gitlab.com
            HostName gitlab.com
            User git
            IdentityFile ~/.ssh/id_gitlab
            IdentitiesOnly yes  

**Observação Importante:** Se você gerenciar múltiplas contas GitHub (pessoal e profissional, por exemplo), pode configurar aliases no arquivo config, como:


        Host github-pessoal
            HostName github.com
            User git
            IdentityFile ~/.ssh/id_github_pessoal
            IdentitiesOnly yes

        Host github-trabalho
            HostName github.com
            User git
            IdentityFile ~/.ssh/id_github_trabalho
            IdentitiesOnly yes  

Então, para clonar um repositório, você usaria:

```bash
git clone git@github-pessoal:usuario/repositorio.git
```

Seguindo esses passos, você terá uma nova chave SSH vinculada ao GitHub e pronta para ser utilizada com seus scripts automatizados e comandos Git.# ssh_git
