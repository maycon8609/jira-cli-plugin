# Jira Task Viewer CLI & Skill

CLI leve e independente (zero dependências externas) e Skill para agentes de IA para consultar tarefas, subtasks e comentários do Jira Cloud em Markdown limpo.

## Recursos

- **Zero dependências externas**: Construído puramente com a biblioteca padrão do Python (`urllib`, `json`, `argparse`).
- **Renderização limpa de ADF**: Converte o Atlassian Document Format (ADF) diretamente em Markdown legível no terminal ou para o agente de IA.
- **Configuração segura**: Credenciais salvas localmente em `~/.config/jira/config.json` com permissões restritas (`600`).
- **Suporte a agentes**: Funciona como CLI interativo e como Skill para o ecossistema Antigravity / Gemini CLI.

---

## Como Obter as Credenciais do Jira

1. Acesse o gerenciador de tokens da Atlassian:
   👉 [https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Clique em **Criar token de API**.
3. Dê um nome ao token (ex: `jira-cli`) e copie o valor gerado.
4. Anote:
   - **URL do Jira**: ex: `https://sua-empresa.atlassian.net`
   - **E-mail**: o mesmo e-mail da sua conta Atlassian
   - **API Token**: o token gerado no passo 3

---

## Instalação Rápida

Clone o repositório e execute o instalador:

```bash
git clone git@github.com:maycon8609/jira-cli-plugin.git
cd jira-cli-plugin
./install.sh
```

O script criará o link simbólico do executável `jira` em `~/.local/bin/` e registrará a skill para o agente.

---

## Como Configurar

Você pode configurar suas credenciais de 3 formas, dependendo do seu fluxo de trabalho:

### 1. Modo Interativo (Mais Prático)

Basta rodar no seu terminal:

```bash
jira --config
```

O assistente solicitará a URL base do Jira, seu e-mail e o API Token gerado na Atlassian, criando o arquivo de configuração automaticamente com permissões restritas de leitura/escrita.

---

### 2. Criação Manual do Arquivo de Configuração

Se preferir criar o arquivo diretamente ou via script sem passar pelo prompt interativo:

1. **Crie a pasta de configuração:**

   ```bash
   mkdir -p ~/.config/jira
   ```

2. **Crie o arquivo `~/.config/jira/config.json`:**

   ```json
   {
     "url": "https://sua-empresa.atlassian.net",
     "email": "seu-email@dominio.com",
     "token": "seu-token-aqui"
   }
   ```

   > **Dica (One-liner no terminal):**
   >
   > ```bash
   > cat << 'EOF' > ~/.config/jira/config.json
   > {
   >   "url": "https://sua-empresa.atlassian.net",
   >   "email": "seu-email@dominio.com",
   >   "token": "SEU_API_TOKEN"
   > }
   > EOF
   > ```

3. **Restrinja as permissões por segurança:**
   Proteja o arquivo para que apenas o seu usuário do sistema operacional possa lê-lo ou editá-lo:
   ```bash
   chmod 600 ~/.config/jira/config.json
   ```

---

### 3. Variáveis de Ambiente (CI/CD, Containers e Sessões)

O CLI suporta variáveis de ambiente nativamente. Elas são a melhor escolha para:

- Pipelines de CI/CD (GitHub Actions, GitLab CI, Bitbucket Pipelines).
- Ambientes de contêineres Docker / Podman onde nenhum arquivo deve ser gravado em disco.
- Máquinas compartilhadas ou sessões temporárias de terminal.

#### Precedência:

As variáveis de ambiente **possuem precedência total** sobre o arquivo `~/.config/jira/config.json`. Se uma variável de ambiente estiver definida, o CLI usará o valor dela em vez do que estiver no arquivo.

#### Variáveis Suportadas:

O CLI aceita tanto o formato padrão quanto apelidos comuns:

| Configuração  | Variável Principal | Variável Alternativa (Alias) | Exemplo                             |
| ------------- | ------------------ | ---------------------------- | ----------------------------------- |
| **URL Base**  | `JIRA_URL`         | `JIRA_BASE_URL`              | `https://sua-empresa.atlassian.net` |
| **E-mail**    | `JIRA_EMAIL`       | `JIRA_USER`                  | `seu-email@dominio.com`             |
| **API Token** | `JIRA_TOKEN`       | `JIRA_API_TOKEN`             | `ATATT3xFfGF0...`                   |

#### Como Definir:

- **Para a sessão atual do terminal:**

  ```bash
  export JIRA_URL="https://sua-empresa.atlassian.net"
  export JIRA_EMAIL="seu-email@dominio.com"
  export JIRA_TOKEN="seu-token-aqui"
  ```

- **De forma persistente para o seu usuário (via shell profile):**
  Adicione os exports no seu arquivo `~/.bashrc` ou `~/.zshrc`:

  ```bash
  echo 'export JIRA_URL="https://sua-empresa.atlassian.net"' >> ~/.bashrc
  echo 'export JIRA_EMAIL="seu-email@dominio.com"' >> ~/.bashrc
  echo 'export JIRA_TOKEN="seu-token-aqui"' >> ~/.bashrc
  source ~/.bashrc
  ```

- **Em pipelines do GitHub Actions (Exemplo):**
  ```yaml
  - name: Consultar Tarefa no Jira
    env:
      JIRA_URL: ${{ secrets.JIRA_URL }}
      JIRA_EMAIL: ${{ secrets.JIRA_EMAIL }}
      JIRA_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
    run: |
      jira IT-123
  ```

---

## Como Usar

### Consultar uma tarefa pelo ID:

```bash
jira PROJ-123
```

### Consultar pela URL completa:

```bash
jira https://sua-empresa.atlassian.net/browse/PROJ-123
```

### Ocultar comentários:

```bash
jira PROJ-123 --no-comments
```

### Exibir resposta em JSON puro:

```bash
jira PROJ-123 --json
```

---

## Desinstalação

Para remover os links criados:

```bash
./uninstall.sh
```
