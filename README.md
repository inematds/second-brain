<div align="center">

<img src="banner.svg" alt="Second Brain" width="800"/>

**Uma IA que já sabe quem você é antes de você digitar uma palavra.**

![macOS](https://img.shields.io/badge/macOS-✓-8A2BE2?style=flat-square) ![Windows](https://img.shields.io/badge/Windows-✓-8A2BE2?style=flat-square) ![Linux](https://img.shields.io/badge/Linux-✓-8A2BE2?style=flat-square) ![Free](https://img.shields.io/badge/custo-grátis-8A2BE2?style=flat-square) ![One command](https://img.shields.io/badge/setup-um_comando-8A2BE2?style=flat-square)

[Obsidian](https://obsidian.md) + [Claude Code](https://claude.ai/code) · Local · Privado · Um comando

```
  Seus arquivos (PDFs, docs, notas)
          │
          ▼
  ┌───────────────────┐
  │   Obsidian vault  │  ← arquivos .md no seu computador
  │  inbox/  daily/   │
  │  projects/  ...   │
  └────────┬──────────┘
           │  Claude Code lê esta pasta
           ▼
  ┌───────────────────┐
  │   Claude Code     │  ← conhece seus projetos, voz, contexto
  │   /vault-setup    │     antes de você digitar uma palavra
  │   /daily  /tldr   │
  └───────────────────┘
           │
           ▼
    IA que se acumula.
    Sessão 1: conhece suas pastas.
    Sessão 20: sabe mais sobre
    seu trabalho do que você lembra conscientemente.
```

*Se isso te economizou horas, deixe uma ⭐ — ajuda outros a encontrar.*

</div>

---

## Início Rápido

### macOS

**Opção A — Uma linha** (cole no Terminal e pressione Enter):

```bash
curl -fsSL https://raw.githubusercontent.com/earlyaidopters/second-brain/main/setup.sh -o setup.sh && bash setup.sh
```

**Opção B — Clonar o repo:**

Abra o **Terminal** (pressione `⌘ Space`, digite `Terminal`, Enter) e rode:

```bash
git clone https://github.com/earlyaidopters/second-brain.git
cd second-brain
./setup.sh
```

> **Não tem git?** Rode `xcode-select --install` primeiro e tente novamente.

---

### Linux

**Opção A — Uma linha:**

```bash
curl -fsSL https://raw.githubusercontent.com/earlyaidopters/second-brain/main/setup.sh -o setup.sh && bash setup.sh
```

**Opção B — Clonar o repo:**

```bash
git clone https://github.com/earlyaidopters/second-brain.git
cd second-brain
./setup.sh
```

> **Pré-requisitos:** `git`, `python3` e `pip` devem estar instalados. Na maioria das distros já vêm por padrão. Se não:
> ```bash
> # Ubuntu/Debian
> sudo apt install git python3 python3-pip python3-venv
>
> # Fedora
> sudo dnf install git python3 python3-pip
>
> # Arch
> sudo pacman -S git python python-pip
> ```

> **Obsidian no Linux** — o script instala automaticamente via Snap, Flatpak ou AppImage. Se preferir instalar manualmente:
> ```bash
> # Snap
> sudo snap install obsidian --classic
>
> # Flatpak
> flatpak install flathub md.obsidian.Obsidian
>
> # AppImage — baixe em https://obsidian.md/download
> chmod +x Obsidian-*.AppImage && ./Obsidian-*.AppImage
> ```

---

### Windows

> **Primeiro: você tem git?**
> Abra o **PowerShell** (pressione `Win`, digite `powershell`, Enter) e rode:
> ```powershell
> git --version
> ```
> Se aparecer um número de versão, está ok. Senão, instale pelo [git-scm.com](https://git-scm.com/download/win) — use todas as opções padrão e reabra o PowerShell.

**Opção A — Uma linha** (cole no PowerShell e pressione Enter):

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/earlyaidopters/second-brain/main/setup.ps1" -OutFile setup.ps1; powershell -ExecutionPolicy Bypass -File setup.ps1
```

**Opção B — Clonar o repo:**

```powershell
git clone https://github.com/earlyaidopters/second-brain.git
cd second-brain
powershell -ExecutionPolicy Bypass -File setup.ps1
```

> **Erro "execução de scripts desabilitada"?** É uma configuração de segurança do Windows. O `-ExecutionPolicy Bypass` no comando acima ignora isso apenas para este script — não muda nada permanente no seu computador.

> **Python não encontrado?** Baixe em [python.org/downloads](https://python.org/downloads) — na primeira tela do instalador, marque **"Add Python to PATH"** antes de clicar em Install. Depois rode o script de setup novamente.

---

O script cuida do resto: instala Obsidian, instala Claude Code, cria seu vault e opcionalmente importa seus arquivos existentes.

---

## Por que Isso Existe

Você já tentou criar um segundo cérebro antes.

Talvez Notion. Talvez Apple Notes. Talvez uma pasta de arquivos markdown que você jurou que ia organizar.

Toda vez, o mesmo resultado: você configurava, usava por uma semana, e depois esquecia completamente que existia.

O problema nunca foi a ferramenta. **Era que você precisava lembrar de usá-la.**

Isto conecta o **Obsidian** (seu vault local de conhecimento) ao **Claude Code** (seu agente de IA) para que:

- Claude Code **leia suas notas** antes de responder — ele conhece seus projetos, seus clientes, sua voz
- Claude Code **escreva suas notas** depois de trabalhar — seu vault se constrói sozinho a partir das sessões
- Seus arquivos existentes (PDFs, docs, slides) são **sintetizados e importados automaticamente** via Gemini 3 Flash
- Tudo fica **local, privado e seu** — sem lock-in de nuvem, sem assinaturas crescentes

O resultado: uma IA que sabe quem você é desde o primeiro prompt de cada sessão. Não porque você contou. Porque ela leu seu vault.

---

## O que é Instalado

| Ferramenta | O que é | Para quê |
|------------|---------|----------|
| **Obsidian** | App gratuito de notas | Suas notas vivem como arquivos `.md` no seu computador — sem nuvem, sem assinatura, seus para sempre |
| **Claude Code** | Terminal IA da Anthropic | Lê e escreve arquivos diretamente no seu vault — sem copiar/colar, sem trocar de aba |
| **Pacotes Python** | Bibliotecas de fundo | Usadas pelo Gemini 3 Flash para ler e sintetizar seus arquivos existentes (PDFs, docs, slides) |
| **Vault skills** | Slash commands | `/vault-setup` `/daily` `/tldr` `/file-intel` — ensinam o Claude a trabalhar com seu vault |
| **Obsidian Skills** *(opcional)* | Skills oficiais do [Kepano](https://github.com/kepano) (CEO do Obsidian) | Permite ao Claude navegar, ler e escrever seu vault nativamente usando a CLI do Obsidian |

> **Nada é enviado para servidores.** Seu vault é uma pasta no seu computador. Claude Code lê localmente. A única chamada de rede opcional é o processamento via Gemini — e é totalmente pulável.

---

## O que o Script de Setup Faz

```
Passo 1 — Verificar dependências       (Homebrew no Mac / winget no Windows / apt/dnf/pacman no Linux)
Passo 2 — Instalar Obsidian            (app gratuito de notas local)
Passo 3 — Instalar Claude Code CLI     (terminal IA da Anthropic)
Passo 4 — Instalar pacotes Python      (para processamento de arquivos via Gemini)
Passo 5 — Criar seu vault              (inbox, daily, projects, research, archive + skills)
Passo 6 — Importar arquivos existentes (opcional — Gemini lê e sintetiza)
Passo 7 — Obsidian Skills              (opcional — skills oficiais do Kepano, CEO do Obsidian)
           └─> Abre o Obsidian apontando para seu novo vault
```

---

## Depois do Setup

### 1. Habilitar a CLI do Obsidian
```
Obsidian → Settings → General → Enable Command Line Interface
```
Isso adiciona o comando `obsidian` ao seu PATH para abrir o vault pelo terminal. ([Docs da CLI](https://help.obsidian.md/cli))

### 2. Abrir o Claude Code no seu vault
```bash
cd ~/second-brain
claude
```

### 3. Rodar seu primeiro comando
```
/vault-setup
```

O Claude Code vai te entrevistar sobre seu papel e trabalho, depois gerar um `CLAUDE.md` personalizado e sugerir slash commands para seu fluxo de trabalho específico. Um empresário recebe pastas diferentes de um desenvolvedor. Um criador de conteúdo recebe comandos diferentes de um consultor.

---

## Slash Commands

Quatro comandos vêm pré-instalados. Mais são adicionados conforme você usa o sistema.

| Comando | O que faz |
|---------|-----------|
| `/vault-setup` | Te entrevista (papel, projetos, objetivos) e gera estrutura personalizada do vault + CLAUDE.md + slash commands customizados |
| `/daily` | Começa seu dia — lê a nota de hoje ou cria uma, mostra prioridades, pergunta no que você está trabalhando |
| `/tldr` | No final de qualquer sessão, salva um resumo estruturado na pasta certa do vault automaticamente |
| `/file-intel` | Aponte para qualquer pasta — Gemini lê cada arquivo e gera resumos prontos para Obsidian no seu inbox |

> **Importante:** Slash commands só ativam quando o Claude Code é aberto de dentro da pasta do vault. Sempre faça `cd` para o vault antes de rodar `claude`.
>
> ```bash
> cd ~/second-brain              # Mac / Linux
> cd $env:USERPROFILE\second-brain   # Windows
> claude
> ```
>
> **Quer que funcionem em qualquer lugar?** Dentro do Claude Code, peça:
> *"Faça esses slash commands globais para funcionarem em qualquer pasta"*
> O Claude Code vai copiar os skills para `~/.claude/skills/`.

---

## Importando Arquivos Existentes

Tem anos de PDFs, documentos Word e apresentações guardados em pastas? Não converta manualmente.

```bash
python3 scripts/process_docs_to_obsidian.py ~/seus-arquivos ~/second-brain/inbox
```

**O que acontece:**
1. Cada arquivo é lido pelo **Gemini 3 Flash** (`gemini-3-flash-preview`)
2. O sinal é extraído, o ruído é descartado (boilerplate jurídico, cabeçalhos, enchimento)
3. Uma nota Markdown limpa e compacta é salva no seu `inbox/` (300–600 palavras máx.)

Depois abra o Claude Code e diga: *"Organize tudo no inbox/ nas pastas certas."*

Ele lê seu CLAUDE.md, entende a estrutura do vault e encaminha cada nota para onde pertence.

**Formatos suportados:** `.pdf` `.docx` `.pptx` `.txt` `.md`

> **Tem arquivos Excel, CSV ou JSON também?** Use o script mais abrangente:
> ```bash
> python3 scripts/process_files_with_gemini.py ~/seus-arquivos
> ```
> Ele processa `.xlsx` `.csv` `.json` `.xml` `.py` `.js` `.html` e a maioria dos arquivos baseados em texto. Resultados ficam em `outputs/file_summaries/` com um `MASTER_SUMMARY.md` resumindo tudo.

---

## Como a Memória Funciona

Seu vault é estruturado para que o Claude Code encontre o contexto certo para qualquer tarefa:

```
~/second-brain/
├── CLAUDE.md        ← O cérebro do cérebro. Lido no início de cada sessão.
├── memory.md        ← Log de sessões. Atualizado pelo Claude Code após cada conversa.
├── inbox/           ← Zona de entrada. Qualquer coisa nova cai aqui primeiro.
├── daily/           ← Notas diárias (YYYY-MM-DD.md). Seu log contínuo.
├── projects/        ← Projetos ativos. Claude lê o relevante antes de ajudar.
├── research/        ← Conhecimento sintetizado. Fontes, notas, ideias.
└── archive/         ← Trabalho concluído. Nunca delete — apenas archive.
```

**O efeito composto:**
- Sessão 1: Claude conhece a estrutura das suas pastas
- Sessão 5: Claude conhece seus projetos, sua voz, suas preferências
- Sessão 20: Claude é seu sistema operacional personalizado — sabe mais sobre sua base de conhecimento do que você lembra conscientemente

> **Nota:** A atualização da memória **não é automática**. Você precisa rodar `/tldr` no final de cada sessão para salvar o resumo, e `/daily` no início do dia para carregar o contexto. Os arquivos não se atualizam sozinhos em background.

---

## Requisitos

| Ferramenta | Plataforma | Como obter |
|------------|-----------|------------|
| Obsidian | macOS | `brew install --cask obsidian` |
| Obsidian | Windows | `winget install Obsidian.Obsidian` |
| Obsidian | Linux | `snap install obsidian --classic` ou `flatpak install flathub md.obsidian.Obsidian` ou [AppImage](https://obsidian.md/download) |
| Claude Code | macOS / Linux | `curl -fsSL https://claude.ai/install.sh \| sh` |
| Claude Code | Windows | `winget install Anthropic.ClaudeCode` |
| Python 3.8+ | Todas | [python.org](https://python.org) |
| Chave API Google | Todas | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) — grátis |
| Conta Claude | Todas | [claude.ai](https://claude.ai) — Pro recomendado para uso intenso |

---

## Estrutura do Repositório

```
second-brain/
├── setup.sh                              ← Setup macOS/Linux (um comando)
├── setup.ps1                             ← Setup Windows (um comando)
├── CLAUDE.md                             ← Arquivo de sistema do vault (personalizado pelo /vault-setup)
├── memory.md                             ← Memória de sessão (atualizado pelo Claude Code)
├── requirements.txt                      ← Dependências Python
├── .env.example                          ← Copie para .env, adicione sua chave API Google
├── .gitignore                            ← Mantém .env e .venv fora do git
├── scripts/
│   ├── process_docs_to_obsidian.py      ← Sintetizador de arquivos via Gemini 3 Flash
│   └── process_files_with_gemini.py     ← Processador batch Gemini
├── skills/
│   ├── vault-setup/SKILL.md             ← Configurador interativo do vault
│   ├── daily/SKILL.md                   ← Comando de standup diário
│   ├── tldr/SKILL.md                    ← Comando de resumo de sessão
│   └── file-intel/SKILL.md              ← Processar qualquer pasta via Gemini
└── vault-template/
    ├── inbox/   daily/   projects/
    ├── research/   archive/
```

---

## Setup Manual

<details>
<summary>Prefere instalar cada peça manualmente? Clique para expandir o passo a passo completo para todas as plataformas.</summary>

---

### macOS — Passos Manuais

**1. Instalar Homebrew** (instalador de apps do macOS — pule se já tem)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Instalar Obsidian**
```bash
brew install --cask obsidian
```

**3. Instalar Claude Code**
```bash
curl -fsSL https://claude.ai/install.sh | sh
```

**4. Baixar e configurar o vault**
```bash
git clone https://github.com/earlyaidopters/second-brain.git
mkdir -p ~/second-brain/{inbox,daily,projects,research,archive,.claude/skills/vault-setup,.claude/skills/daily,.claude/skills/tldr,.claude/skills/file-intel,scripts}
cp second-brain/CLAUDE.md second-brain/memory.md ~/second-brain/
cp second-brain/skills/vault-setup/SKILL.md ~/second-brain/.claude/skills/vault-setup/
cp second-brain/skills/daily/SKILL.md ~/second-brain/.claude/skills/daily/
cp second-brain/skills/tldr/SKILL.md ~/second-brain/.claude/skills/tldr/
cp second-brain/skills/file-intel/SKILL.md ~/second-brain/.claude/skills/file-intel/
cp second-brain/scripts/* ~/second-brain/scripts/
cp second-brain/.env.example ~/second-brain/.env
```

**5. Adicionar sua chave API Google**

Abra `~/second-brain/.env` em qualquer editor e substitua `your_key_here` pela sua chave de [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

**6. (Opcional) Instalar Obsidian Skills do Kepano**
```bash
git clone --depth=1 https://github.com/kepano/obsidian-skills.git /tmp/obs-skills
for d in /tmp/obs-skills/skills/*/; do
  name=$(basename "$d")
  mkdir -p ~/second-brain/.claude/skills/$name
  cp "$d/SKILL.md" ~/second-brain/.claude/skills/$name/
done
rm -rf /tmp/obs-skills
```

**7. Abrir Claude Code no vault**
```bash
cd ~/second-brain && claude
```

---

### Linux — Passos Manuais

**1. Instalar dependências**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y git python3 python3-pip python3-venv curl

# Fedora
sudo dnf install -y git python3 python3-pip curl

# Arch
sudo pacman -S --noconfirm git python python-pip curl
```

**2. Instalar Obsidian**
```bash
# Opção 1: Snap (Ubuntu e derivados)
sudo snap install obsidian --classic

# Opção 2: Flatpak
flatpak install flathub md.obsidian.Obsidian

# Opção 3: AppImage
# Baixe o .AppImage em https://obsidian.md/download
chmod +x Obsidian-*.AppImage
./Obsidian-*.AppImage
```

**3. Instalar Claude Code**
```bash
curl -fsSL https://claude.ai/install.sh | sh
```

**4. Baixar e configurar o vault**
```bash
git clone https://github.com/earlyaidopters/second-brain.git
mkdir -p ~/second-brain/{inbox,daily,projects,research,archive,.claude/skills/vault-setup,.claude/skills/daily,.claude/skills/tldr,.claude/skills/file-intel,scripts}
cp second-brain/CLAUDE.md second-brain/memory.md ~/second-brain/
cp second-brain/skills/vault-setup/SKILL.md ~/second-brain/.claude/skills/vault-setup/
cp second-brain/skills/daily/SKILL.md ~/second-brain/.claude/skills/daily/
cp second-brain/skills/tldr/SKILL.md ~/second-brain/.claude/skills/tldr/
cp second-brain/skills/file-intel/SKILL.md ~/second-brain/.claude/skills/file-intel/
cp second-brain/scripts/* ~/second-brain/scripts/
cp second-brain/.env.example ~/second-brain/.env
```

**5. Instalar dependências Python**
```bash
python3 -m venv ~/.second-brain-venv
~/.second-brain-venv/bin/pip install -r second-brain/requirements.txt
```

**6. Adicionar sua chave API Google**

Abra `~/second-brain/.env` em qualquer editor e substitua `your_key_here` pela sua chave de [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

**7. (Opcional) Instalar Obsidian Skills do Kepano**
```bash
git clone --depth=1 https://github.com/kepano/obsidian-skills.git /tmp/obs-skills
for d in /tmp/obs-skills/skills/*/; do
  name=$(basename "$d")
  mkdir -p ~/second-brain/.claude/skills/$name
  cp "$d/SKILL.md" ~/second-brain/.claude/skills/$name/
done
rm -rf /tmp/obs-skills
```

**8. Abrir Claude Code no vault**
```bash
cd ~/second-brain && claude
```

---

### Windows — Passos Manuais

Abra o **PowerShell** para todos os comandos abaixo.

**1. Instalar Obsidian**
```powershell
winget install Obsidian.Obsidian
```

**2. Instalar Claude Code**
```powershell
winget install Anthropic.ClaudeCode
```
Feche e reabra o PowerShell após este passo.

**3. Instalar Python** (se não tem)

Baixe de [python.org/downloads](https://python.org/downloads). Na primeira tela do instalador, marque **"Add Python to PATH"** antes de clicar em Install.

**4. Baixar e configurar o vault**
```powershell
git clone https://github.com/earlyaidopters/second-brain.git
$vault = "$env:USERPROFILE\second-brain"
New-Item -ItemType Directory -Force -Path "$vault\inbox","$vault\daily","$vault\projects","$vault\research","$vault\archive","$vault\scripts","$vault\.claude\skills\vault-setup","$vault\.claude\skills\daily","$vault\.claude\skills\tldr","$vault\.claude\skills\file-intel" | Out-Null
Copy-Item "second-brain\CLAUDE.md","second-brain\memory.md" $vault
Copy-Item "second-brain\skills\vault-setup\SKILL.md" "$vault\.claude\skills\vault-setup\"
Copy-Item "second-brain\skills\daily\SKILL.md" "$vault\.claude\skills\daily\"
Copy-Item "second-brain\skills\tldr\SKILL.md" "$vault\.claude\skills\tldr\"
Copy-Item "second-brain\skills\file-intel\SKILL.md" "$vault\.claude\skills\file-intel\"
Copy-Item "second-brain\scripts\*" "$vault\scripts\"
Copy-Item "second-brain\.env.example" "$vault\.env"
```

**5. Instalar dependências Python**
```powershell
pip install -r second-brain\requirements.txt
```

**6. Adicionar sua chave API Google**

Abra `%USERPROFILE%\second-brain\.env` no Bloco de Notas e substitua `your_key_here` pela sua chave de [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

**7. (Opcional) Instalar Obsidian Skills do Kepano**
```powershell
$tmp = "$env:TEMP\obs-skills"
git clone --depth=1 https://github.com/kepano/obsidian-skills.git $tmp
Get-ChildItem "$tmp\skills" -Directory | ForEach-Object {
    $dest = "$env:USERPROFILE\second-brain\.claude\skills\$($_.Name)"
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item "$($_.FullName)\SKILL.md" "$dest\" -Force
}
Remove-Item $tmp -Recurse -Force
```

**8. Abrir Claude Code no vault**
```powershell
cd "$env:USERPROFILE\second-brain"
claude
```

</details>

---

## Perguntas Frequentes

**Meus dados são privados?**
Sim. O Obsidian armazena tudo como arquivos markdown locais no seu computador. Nada é enviado para nenhum servidor. O Claude Code processa seus arquivos localmente na pasta onde você o abre. A única vez que algo sai da sua máquina é quando você chama a API do Gemini para processar arquivos existentes — e isso é opcional.

**Preciso de uma conta Claude paga?**
O tier gratuito funciona para uso leve. Para uso diário com sessões longas, o Claude Pro (US$ 20/mês) oferece substancialmente mais uso do que custos equivalentes de API em outras ferramentas.

**E se eu já tiver um vault do Obsidian?**
O script de setup pergunta onde fica seu vault. Aponte para o vault existente — ele vai copiar o template do CLAUDE.md, skills e scripts sem tocar nas suas notas existentes.

**Posso usar sem o processamento de arquivos?**
Com certeza. A chave API do Gemini e o processamento de arquivos são opcionais. O sistema central (Obsidian + Claude Code + CLAUDE.md + slash commands) funciona sem isso.

**O Obsidian é obrigatório?**
Não. O vault é feito de arquivos Markdown comuns. Você pode usar qualquer editor (VS Code, Typora, Neovim, etc.). O Obsidian agrega valor pelo graph view, plugins da comunidade e CLI integrada, mas não é requisito.

**As notas se atualizam sozinhas?**
Não. Você precisa rodar `/daily` no início do dia e `/tldr` no final de cada sessão. Não há automação em background — tudo é acionado manualmente por comando.

---

<div align="center">

Criado por [Mark Kashef](https://youtube.com/@marwankashef) · [Prompt Advisers](https://promptadvisers.com)

*Se isso te ajudou a criar seu segundo cérebro, deixe uma ⭐ — ajuda outros a encontrar.*

</div>
