# Jira Task Viewer CLI & Skill

Lightweight, standalone CLI (zero external dependencies) and AI Agent Skill to fetch, parse, and view Jira Cloud tasks, subtasks, and comments in clean Markdown.

## Features

- **Zero External Dependencies**: Built entirely with Python's standard library (`urllib`, `json`, `argparse`).
- **Clean ADF Rendering**: Recursively parses Atlassian Document Format (ADF) into readable Markdown for terminals and AI agents.
- **Secure Configuration**: Stores credentials locally in `~/.config/jira/config.json` with strict user-only permissions (`0600`), or via environment variables.
- **AI Agent Skill**: Ready-to-use skill compatible with Antigravity and Agent ecosystems.

---

## How to Get Your Jira Credentials

1. Go to Atlassian API Tokens management:  
   👉 [https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click **Create API token**.
3. Label your token (e.g., `jira-cli`) and copy the generated secret.
4. Keep the following information handy:
   - **Jira URL**: e.g., `https://your-domain.atlassian.net`
   - **Email**: your Atlassian account email address
   - **API Token**: the token created in step 3

---

## Quick Installation

Clone the repository and run the installer:

```bash
git clone git@github.com:maycon8609/jira-cli-plugin.git
cd jira-cli-plugin
./install.sh
```

The script symlinks the `jira` binary to `~/.local/bin/` and registers the skill for AI agent workflows.

---

## Configuration

You can configure your credentials using any of the 3 approaches below:

### 1. Interactive Setup (Recommended)

Run directly in your terminal:

```bash
jira --config
```

The wizard prompts for your Jira URL, email, and API Token, writing the configuration automatically with secure `0600` permissions.

---

### 2. Manual Configuration File

If you prefer to configure directly or via a shell script without interactive prompts:

1. **Create the configuration directory:**
   ```bash
   mkdir -p ~/.config/jira
   ```

2. **Create `~/.config/jira/config.json`:**
   ```json
   {
     "url": "https://your-domain.atlassian.net",
     "email": "your-email@domain.com",
     "token": "your-api-token"
   }
   ```

   > **One-liner shortcut:**
   > ```bash
   > cat << 'EOF' > ~/.config/jira/config.json
   > {
   >   "url": "https://your-domain.atlassian.net",
   >   "email": "your-email@domain.com",
   >   "token": "YOUR_API_TOKEN"
   > }
   > EOF
   > ```

3. **Restrict permissions:**
   ```bash
   chmod 600 ~/.config/jira/config.json
   ```

---

### 3. Environment Variables (CI/CD, Containers, and Sessions)

The CLI natively supports environment variables, ideal for:
- CI/CD pipelines (GitHub Actions, GitLab CI, Bitbucket Pipelines).
- Docker / Podman container environments where disk persistence is discouraged.
- Shared machines or temporary terminal sessions.

#### Precedence:
Environment variables take **full precedence** over `~/.config/jira/config.json`. If an environment variable is set, the CLI prioritizes its value.

#### Supported Variables:

| Setting | Primary Variable | Alias | Example |
|---|---|---|---|
| **Base URL** | `JIRA_URL` | `JIRA_BASE_URL` | `https://your-domain.atlassian.net` |
| **Email** | `JIRA_EMAIL` | `JIRA_USER` | `your-email@domain.com` |
| **API Token** | `JIRA_TOKEN` | `JIRA_API_TOKEN` | `ATATT3xFfGF0...` |

#### How to Set:

- **For the current terminal session:**
  ```bash
  export JIRA_URL="https://your-domain.atlassian.net"
  export JIRA_EMAIL="your-email@domain.com"
  export JIRA_TOKEN="your-api-token"
  ```

- **Persistently in your shell profile:**
  Add the exports to your `~/.bashrc` or `~/.zshrc`:
  ```bash
  echo 'export JIRA_URL="https://your-domain.atlassian.net"' >> ~/.bashrc
  echo 'export JIRA_EMAIL="your-email@domain.com"' >> ~/.bashrc
  echo 'export JIRA_TOKEN="your-api-token"' >> ~/.bashrc
  source ~/.bashrc
  ```

- **In GitHub Actions workflows (Example):**
  ```yaml
  - name: Fetch Jira Issue
    env:
      JIRA_URL: ${{ secrets.JIRA_URL }}
      JIRA_EMAIL: ${{ secrets.JIRA_EMAIL }}
      JIRA_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
    run: |
      jira PROJ-123
  ```

---

## Usage

### Fetch an issue by key:

```bash
jira PROJ-123
```

### Fetch using direct issue URL:

```bash
jira https://your-domain.atlassian.net/browse/PROJ-123
```

### Hide comments section:

```bash
jira PROJ-123 --no-comments
```

### Output raw JSON response:

```bash
jira PROJ-123 --json
```

---

## Uninstallation

To remove symlinks created during installation:

```bash
./uninstall.sh
```

## License

MIT
