<p align="center">
  <img src="https://secrethub.io/img/integrations/github-actions/github-banner.png?v1" alt="GitHub Actions + SecretHub" width="390">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/integrations/github-actions/"><img alt="Learn More" src="https://secrethub.io/img/buttons/github/learn-more.png?v2" height="28" /></a>
</p>
<br/>


# Actions

[![CI](https://github.com/secrethub/actions/workflows/.github/workflows/main.yml/badge.svg)](https://github.com/secrethub/actions/actions)
[![Version](https://img.shields.io/github/release/secrethub/actions.svg)](https://github.com/secrethub/actions/releases/latest)
[![Discord](https://img.shields.io/badge/chat-on%20discord-7289da.svg?logo=discord)](https://discord.gg/NWmxVeb)

No more copy-pasting sensitive values into a GUI. Securely load secrets into GitHub Actions and sync them automatically.

## secrethub/actions/env-export

The `env-export` action reads all referenced secrets from environment variables prefixed by `secrethub://` and secrets specified in the `secrethub.env` template file, and makes the secret values available as environment variables to the rest of the job.

It leverages GitHub's output masking feature, so if secret values are (accidentally) logged, they get replaced with `*****`.

### Usage

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
        # This action expects SLACK_WEBHOOK to be set, which is now done automatically
        uses: Ilshidur/action-slack@2.0.1
        with:
          args: Sent from GitHub Actions with secrets from SecretHub 🔑
```
