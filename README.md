<p align="center">
  <a href="https://github.com/features/actions">
    <img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg" alt="GitHub" width="120">
  </a>
  <img width="50px"/>
  <a href="https://secrethub.io">
    <img src="https://secrethub.io/img/secrethub-logo-shield.svg" alt="SecretHub" width="102">
  </a>
</p>
<h1 align="center">
  <i>GitHub Actions</i>
</h1>

[![Version]( https://img.shields.io/github/release/secrethub/actions.svg)](https://github.com/secrethub/actions/releases/latest)
[![Discord](https://img.shields.io/badge/chat-on%20discord-7289da.svg?logo=discord)](https://discord.gg/NWmxVeb)

> [SecretHub](https://secrethub.io) is an end-to-end encrypted secret management service that helps developers keep database passwords, API keys, and other secrets out of source code.

## Actions

### secrethub/actions/env-export

The `env-export` action reads all referenced secrets from environment variables prefixed by `secrethub://` and secrets specified in the `secrethub.env` template file, and makes the secret values available as environment variables to the rest of the job.

It leverages GitHub's output masking feature, so if secret values are (accidentally) logged, they get replaced with `*****`.

#### Usage

```yml
on: push
jobs:
  notify-slack:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: secrethub/actions/env-export@v0.1.0
        env:
          SECRETHUB_CREDENTIAL: ${{ secrets.SECRETHUB_CREDENTIAL }}
          SLACK_WEBHOOK: secrethub://company/app/slack/webhook
      - name: Print environment with masked secrets
        run: printenv
      - name: Notify Slack
        uses: Ilshidur/action-slack@2.0.1 # the SLACK_WEBHOOK gets set automatically
        with:
          args: Sent from GitHub Actions with secrets from SecretHub 🔑
```
