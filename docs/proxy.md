# Proxy Configuration

If your network requires a proxy, create a repository-local `.proxy.env` file before running the setup scripts.

## Quick Start

```bash
cp .proxy.env.example .proxy.env
```

Then edit `.proxy.env` with your actual values:

```bash
HTTP_PROXY=http://proxy.example.com:8080
HTTPS_PROXY=http://proxy.example.com:8080
NO_PROXY=localhost,127.0.0.1,::1
```

## Behavior

- `.proxy.env` is loaded automatically by setup steps that use the network.
- Both uppercase and lowercase proxy environment variables are synchronized.
- `sudo apt ...` and `sudo gem ...` commands receive the proxy variables as well.
- If you already export proxy variables in your shell, the scripts will use them even without `.proxy.env`.
