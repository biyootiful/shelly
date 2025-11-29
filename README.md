# Shelly

A simple, powerful CLI tool that pipes your questions directly to a local LLM via Ollama. Get instant help with commands, error debugging, and general questions - right from your terminal.

## Features

- **Command lookups** - "what's the AWS command for listing S3 buckets?"
- **Error catching** - Automatically suggests fixes when commands fail
- **General assistance** - Revise messages, explain concepts, answer questions
- **Model selection** - Choose from any Ollama model with an interactive selector
- **Oh My Zsh integration** - Simple plugin installation

## Quick Start

### Prerequisites

Install Ollama:
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Pull a model (recommended):
```bash
ollama pull llama3.2
# or
ollama pull qwen2.5-coder
# or any other model you prefer
```

### Installation

```bash
curl -fsSL https://raw.githubusercontent.com/biyootiful/shelly/main/install.sh | bash
```

The installer will:
- Install Shelly to `~/.local/bin`
- Auto-detect and install Oh My Zsh plugin (if applicable)
- Guide you through setup

### Oh My Zsh Setup

If you use Oh My Zsh, add `shelly` to your plugins in `~/.zshrc`:

```bash
plugins=(git shelly ...)
```

Then reload your shell:
```bash
source ~/.zshrc
```

### Manual Setup (without Oh My Zsh)

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
source "$HOME/.shelly/shelly-trap"  # Optional: for auto error catching
```

## Usage

### Basic queries

```bash
shelly "what's the command for listing files recursively?"
shelly "how do I find large files in current directory?"
shelly "revise this message: hey man whats up"
```

### Model management

First time you run Shelly, it will prompt you to select a model from your installed Ollama models.

```bash
# Change model anytime
shelly --model

# Show current model
shelly --show-model
```

### Error catching

When Oh My Zsh plugin is enabled or trap script is sourced:

```bash
# If a command fails, use shelp to get help
some-failing-command
shelp  # Analyzes the last failed command and suggests fixes
```

### Aliases (with Oh My Zsh plugin)

```bash
s "your question"           # Short for shelly
shelp                       # Catch and explain last error
scmd "listing files"        # Short for "what is the command for"
```

## Configuration

Shelly stores its configuration in `~/.shelly/`:
- `config` - Selected model
- `shelly` - Main script
- `shelly-trap` - Error catching functions

### Environment Variables

```bash
export SHELLY_MODEL=qwen2.5-coder    # Override configured model
export SHELLY_HOST=http://localhost:11434  # Custom Ollama host
```

## Examples

```bash
# Command lookups
shelly "whats the command for looking up aws s3 bucket list?"

# Git help
shelly "how do I undo my last commit?"

# Text revision
shelly "revise this message to be more professional: yo check this out"

# Error debugging (after a failed command)
shelp
```

## Requirements

- Bash or Zsh
- [Ollama](https://ollama.com) installed and running
- At least one Ollama model pulled
- `curl` and `jq` (usually pre-installed)

## Uninstall

```bash
rm -rf ~/.shelly
rm ~/.local/bin/shelly
```

Remove `shelly` from your Oh My Zsh plugins or remove the source line from your `.zshrc`/`.bashrc`.

## License

MIT

## Contributing

Issues and PRs welcome!
