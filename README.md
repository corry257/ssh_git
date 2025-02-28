
# Gerando e Configurando uma Nova Chave SSH para o GitHub no Linux

Este tutorial ensina como gerar uma nova chave SSH para vincular ao GitHub em sistemas Linux e como configurar o arquivo `config` dentro da pasta `.ssh` para facilitar o uso com scripts e conexões, você pode só copiar os comandos e colar no terminal do seu sistema linux, mas é interessante para o seu aprendizado tentar entender os passos antes de copiá-los, pois caso surja eventuais problemas no futuro, você tenha autonomia para resolve-los por conta própria.

---

## 1. Verificar Chaves Existentes

Antes de criar uma nova chave, é recomendado verificar se você já possui alguma chave SSH configurada.

```bash
ls ~/.ssh
```

Se existirem arquivos como `id_rsa`, `id_rsa.pub` ou `config`, significa que você já tem alguma configuração anterior.

> O arquivo `id_rsa` é uma chave privada antiga e o `id_rsa.pub` é a correspondente chave pública. O arquivo `config` é opcional, mas muito útil para organizar múltiplas chaves.

---

## 2. Criar uma Nova Chave SSH

Execute o comando abaixo para gerar uma nova chave SSH.

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com" -f ~/.ssh/id_github
```
Caso queira dar outro nome diferente de 'id_github' para a chave ssh execute esse outro comando abaixo

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"
```
Durante a geração da chave:

- Escolha o diretório e o nome do arquivo (exemplo: `~/.ssh/id_github_trabalho`).
- Pode deixar a senha de proteção em branco ou definir uma (opcional).

Você também pode substituir o caminho do repositório que deseja salvar a chave e substituir o nome da chave também, por exemplo: 

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com" -f /home/seu_nome/diretorio1/diretorio2/nome_da_chave
```

Atente-se que o exemplo acima é só uma demonstração, você deve escrever o caminho onde deseja salvar a chave e o nome da chave de acordo com o seu computador e a sua preferência de nome.  
  
Fique a vontade para escolher qualquer um dos três métodos, o importante é você entender o que está fazendo, o primeiro modo você só precisa copiar e colar no terminal, mas também não tem liberdade para escolher o nome nem onde vai salvar a chave.  

- **`-t ed25519`**: Cria uma chave moderna e mais segura.
- **`-C`**: Adiciona um comentário à chave, geralmente o seu e-mail.
- **`-f`**: Cria o caminho do diretório e o nome da chave diretamente no comando.

---

## 3. Adicionar a Chave SSH ao Agente SSH

Certifique-se de que o `ssh-agent` está rodando.

```bash
eval "$(ssh-agent -s)"
```

### Verificar se o agente já possui chaves carregadas

```bash
ssh-add -l
```

Se o agente não estiver rodando, esse comando mostrará uma mensagem de erro. Se ele estiver rodando, listará as chaves já adicionadas.

### Listar as chaves disponíveis

Para listar o par de chave que você acabou de criar execute o comando abaixo: 

```bash
ls ~/.ssh
```

Um exemplo de saída:

```
id_github    id_github.pub    config    nome_da_chave    nome_da_chave.pub
```

Outro comando que também lista as chaves é este abaixo, ele é um comando mais completo e mostra mais informações das chaves.

```bash
ls -la ~/.ssh
```

Exemplo de saída:

```
-rw-------  1 seu-usuario seu-usuario  464 Feb  8 15:41 id_github
-rw-r--r--  1 seu-usuario seu-usuario  109 Feb  8 15:41 id_github.pub
-rw-rw-r--  1 seu-usuario seu-usuario 260 Feb 28 00:19 config
-rw-------  1 seu-usuario seu-usuario  978 Aug  3  2024 nome_da_chave
-rw-r--r--  1 seu-usuario seu-usuario  142 Aug  3  2024 nome_da_chave.pub
```

Caso queira entender melhor essa lista acima, leia o manual básico sobre GNU/Linux cliando [aqui](https://www.debian.org/doc/manuals/debian-reference/ch01.pt.html#_console_basics), você vai encontrar mais especificamente a explicação da lista acima na sessão: **1.2.3. Permissões do sistema de ficheiros** do manual.

### Adicionar a chave recém-criada ao agente

```bash
ssh-add ~/.ssh/nome_da_chave
```

Substitua `nome_da_chave` pelo nome da sua chave, como por exemplo: `id_github_trabalho`.  

Caso esteja usando o mesmo nome da chave do tutorial ou esteja somente copiando e colando no seu terminal, copie e cole no seu terminal esse comando abaixo: 

```bash
ssh-add ~/.ssh/id_github
```

---

## 4. Criar ou Atualizar o Arquivo Config

Crie ou edite o arquivo `~/.ssh/config` para associar a nova chave SSH ao GitHub.

```bash
nano ~/.ssh/config
```

- **`nano`**: Abre uma editor de texto para terminal no linux.  (Existem outros editores de texto)
- **`~/.ssh/config`**: Cria ou abre um arquivo no caminho indicado. (o caminho neste caso é o repositório /home/seu_usuário/.ssh/ e o nome do arquivo é config)  
Você deve escrever dentro dese arquivo que abriu configurações para as suas chaves ssh, é uma boa maneira de gerenciar multiplas chaves para diversos propósitos.

Exemplo de configuração:

```
# Chave SSH para GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/nome_da_chave
    IdentitiesOnly yes
```

- **Host**: Define um apelido para o host. (neste caso o apelido ficou github.com mas pode ser qualquer um, você define)
- **HostName**: Nome real do host.
- **User**: Usuário SSH (sempre `git` para GitHub).
- **IdentityFile**: Caminho para a chave privada. (o caminho vai depender de onde você salvou as suas chaves)
- **IdentitiesOnly**: Garante que apenas essa chave será usada.

Salve (CTRL+O e ENTER) e saia (CTRL+X).

---

## 5. Copiar a Chave Pública

Para vincular ao GitHub, copie o conteúdo da chave pública.

```bash
cat ~/.ssh/nome_da_chave.pub
```

Caso esteja usando o mesmo nome do tutorial ou somente copiando e colando, copie o comando abaixo e cole no seu terminal: 

```bash
cat ~/.ssh/id_github
```
O terminal irá exibir algo assim: 

```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlgbLWNlhScqb2UB76JVGGVkli8flmO+5Z8CSSNY7GidjMIzkznsjfndfjbdfkjfi877ruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn8788989Jjhefuer77JHGG9787
-----END OPENSSH PRIVATE KEY-----
```

Copie todo o conteúdo exibido no terminal.

---

## 6. Adicionar a Chave Pública no GitHub

1. Acesse: [https://github.com/settings/keys](https://github.com/settings/keys)
2. Clique em **New SSH Key**.
3. No campo **Title**, insira um nome identificador (ex: "Chave Linux Pessoal").
4. No campo **Key**, cole a chave pública copiada.
5. Clique em **Add SSH Key**.

---

## 7. Testar Conexão com o GitHub

Execute o comando:

```bash
ssh -T git@github.com
```

Se tudo estiver certo, verá algo como:

```
Hi seu-usuario! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 8. Configuração Final para Scripts e Múltiplas Contas

O arquivo `~/.ssh/config` é essencial para que scripts e comandos `git` utilizem a chave correta. Se você tiver múltiplas chaves (pessoal, trabalho, etc.), o arquivo pode conter:

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/nome_da_chave_pessoal
    IdentitiesOnly yes

Host github-trabalho     #CUSTOM_HOST
    HostName github.com
    User git
    IdentityFile ~/.ssh/nome_da_chave_trabalho
    IdentitiesOnly yes
```

### Exemplo de clone usando o alias do `config`

```bash
git clone git@github-trabalho:usuario/repositorio.git
```

---

## 9. Permissões de Segurança Recomendadas

Para evitar problemas de permissão:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/nome_da_chave
chmod 644 ~/.ssh/nome_da_chave.pub
```

Caso tenha lido o manual para GNU/Linux vai conseguir entender muito bemm esses comandos acima, então fica aqui mais uma vez a recomendação de leitura do manual clicando [aqui](https://www.debian.org/doc/manuals/debian-reference/ch01.pt.html#_console_basics).  

---

## 10. Resumo Final

| Etapa                                  | Comando Exemplo                                             |
|-------------------------------------|----------------------------------------------------|
| Verificar chaves existentes        | `ls -la ~/.ssh`                                   |
| Gerar chave                         | `ssh-keygen -t ed25519 -C "seu-email@exemplo.com"` |
| Adicionar ao agente                 | `ssh-add ~/.ssh/nome_da_chave`                     |
| Configurar `config`                 | editar `~/.ssh/config`                             |
| Copiar chave pública                | `cat ~/.ssh/nome_da_chave.pub`                     |
| Testar conexão                      | `ssh -T git@github.com`                            |
| Testar conexão personalizada     | `ssh -T github-trabalho`  ou  `ssh -T CUSTOM_HOST/apelido do host que você criou`|
---

## Observações Finais

- Nunca compartilhe sua chave privada.
- Use `ed25519` para segurança e performance.
- O arquivo `~/.ssh/config` facilita a organização de múltiplas chaves e é fundamental em ambientes com várias contas.
- Verifique as permissões da pasta e arquivos para evitar erros de "Permission denied".


