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

Você pode configurar suas credenciais de 3 formas:

### 1. Modo Interativo (Recomendado)
Execute no terminal:
```bash
jira --config
```
O utilitário solicitará a URL, e-mail e token, salvando em `~/.config/jira/config.json` com permissão restrita `600`.

### 2. Variáveis de Ambiente
Útil para ambientes de CI/CD ou sessões temporárias:
```bash
export JIRA_URL="https://sua-empresa.atlassian.net"
export JIRA_EMAIL="seu-email@dominio.com"
export JIRA_TOKEN="seu-token-aqui"
```

### 3. Arquivo Direto
Crie manualmente o arquivo `~/.config/jira/config.json`:
```json
{
  "url": "https://sua-empresa.atlassian.net",
  "email": "seu-email@dominio.com",
  "token": "seu-token-aqui"
}
```
E restrinja as permissões:
```bash
chmod 600 ~/.config/jira/config.json
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
