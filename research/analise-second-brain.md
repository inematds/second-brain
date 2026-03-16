# Análise do Projeto Second Brain

**Data:** 2026-03-16

---

## O que é

Um "Segundo Cérebro" que conecta **Obsidian** (notas locais em Markdown) com **Claude Code** (IA no terminal) para criar um sistema de conhecimento pessoal que se auto-alimenta a cada sessão.

---

## Arquitetura

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

---

## Estrutura de pastas do vault

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

---

## Fluxo de funcionamento

### 1. Setup (`setup.sh` / `setup.ps1`)
- Instala Obsidian, Claude Code e dependências Python
- Cria a estrutura de pastas do vault
- Copia os skills (slash commands) e scripts

### 2. Personalização (`/vault-setup`)
- Claude te entrevista sobre seu papel, projetos e objetivos
- Gera um `CLAUDE.md` personalizado — esse arquivo é lido no início de toda sessão

### 3. Uso diário — os 4 slash commands

| Comando | O que faz |
|---------|-----------|
| `/vault-setup` | Entrevista você (papel, projetos, objetivos) e gera estrutura personalizada + CLAUDE.md + comandos customizados |
| `/daily` | Começa seu dia — lê a nota de hoje ou cria uma, mostra prioridades, pergunta no que está trabalhando |
| `/tldr` | No final de qualquer sessão, salva um resumo estruturado na pasta certa do vault automaticamente |
| `/file-intel` | Aponte para qualquer pasta — Gemini lê cada arquivo e gera resumos prontos para Obsidian no inbox |

### 4. Importação de arquivos existentes
- `scripts/process_docs_to_obsidian.py` — usa Gemini para ler PDFs/docs e gerar notas compactas (300-600 palavras)
- `scripts/process_files_with_gemini.py` — versão mais ampla (Excel, CSV, JSON, código)

### 5. Efeito composto
- `CLAUDE.md` + `memory.md` são lidos a cada sessão
- Quanto mais você usa, mais contexto o Claude acumula
- Tudo fica local — são arquivos `.md` na sua máquina

---

## O que é instalado

| Ferramenta | O que é | Para quê |
|------------|---------|----------|
| **Obsidian** | App gratuito de notas | Notas vivem como arquivos `.md` no seu computador — sem nuvem, sem assinatura |
| **Claude Code** | Terminal IA da Anthropic | Lê e escreve arquivos diretamente no vault — sem copiar/colar |
| **Pacotes Python** | Bibliotecas de fundo | Usadas pelo Gemini 3 Flash para ler e sintetizar arquivos existentes |
| **Vault skills** | Slash commands | `/vault-setup` `/daily` `/tldr` `/file-intel` |
| **Obsidian Skills** *(opcional)* | Skills oficiais do Kepano (CEO do Obsidian) | Permite Claude navegar o vault via CLI do Obsidian |

---

## Limitações identificadas

### Sem atualização automática
- Nada é automático — `/daily`, `/tldr`, `/file-intel` precisam ser rodados manualmente
- O `memory.md` só é atualizado quando o Claude Code escreve nele durante uma sessão
- Não há cron, hook ou automação em background

### Sem suporte a Linux no setup
- `setup.sh` verifica `$OSTYPE` na linha 78 e **rejeita qualquer coisa que não seja `darwin*` (macOS)**
- Obsidian no Linux precisa ser instalado manualmente via:
  - `sudo snap install obsidian --classic`
  - `flatpak install flathub md.obsidian.Obsidian`
  - AppImage (baixar de obsidian.md/download)
- Claude Code no Linux funciona normalmente via `curl -fsSL https://claude.ai/install.sh | sh`

### Obsidian é opcional
- O vault funciona sem o Obsidian — são apenas arquivos Markdown
- Qualquer editor (VS Code, Typora, etc.) serve
- Obsidian agrega: graph view, plugins da comunidade, CLI

---

## Possíveis automações futuras
1. **Hooks do Claude Code** — hook `post-session` para rodar `/tldr` automaticamente
2. **Cron job** — processar `inbox/` em horários fixos
3. **Obsidian plugins** — Templater para notas diárias automáticas ao abrir o app

---

## Estrutura do repositório

```
second-brain/
├── setup.sh                              ← Setup macOS (one-command)
├── setup.ps1                             ← Setup Windows (one-command)
├── CLAUDE.md                             ← Arquivo de sistema do vault
├── memory.md                             ← Memória de sessão
├── requirements.txt                      ← Dependências Python
├── scripts/
│   ├── process_docs_to_obsidian.py      ← Sintetizador Gemini 3 Flash
│   └── process_files_with_gemini.py     ← Processador batch Gemini
├── skills/
│   ├── vault-setup/SKILL.md             ← Configurador interativo
│   ├── daily/SKILL.md                   ← Comando de standup diário
│   ├── tldr/SKILL.md                    ← Comando de resumo de sessão
│   └── file-intel/SKILL.md             ← Processar pasta via Gemini
└── vault-template/
    ├── inbox/   daily/   projects/
    ├── research/   archive/
```
