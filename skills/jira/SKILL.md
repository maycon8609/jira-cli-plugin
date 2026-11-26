---
name: jira
description: Fetches and formats Jira tasks, issues, subtasks, descriptions, and comments in clean Markdown. Use whenever asked to look up a Jira issue, check acceptance criteria, inspect ticket details, or summarize card progress.
---

# Jira Task Viewer Skill

Consulta e exibe detalhes de tarefas do Jira (resumo, descrição formatada, subtasks, responsáveis e últimos comentários) em Markdown limpo, sem dependências externas.

## Como Usar

Execute o comando `jira <KEY>` no terminal:

```bash
jira PROJ-123
```

Ou passe a URL direta do card:
```bash
jira https://sua-empresa.atlassian.net/browse/PROJ-123
```

### Opções Disponíveis

- `jira PROJ-123`: Exibe visão completa com descrição, subtasks e comentários recentes.
- `jira PROJ-123 --no-comments`: Oculta a seção de comentários.
- `jira PROJ-123 --json`: Retorna os dados brutos da API em formato JSON.
- `jira --config`: Permite reconfigurar a URL, o e-mail e o API Token de forma interativa.
