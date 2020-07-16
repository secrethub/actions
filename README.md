<p align="center">
  <img src="https://secrethub.io/img/integrations/github-actions/github-banner.png?v2" alt="GitHub Actions + SecretHub" width="390">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/integrations/github-actions/"><img alt="Learn More" src="https://secrethub.io/img/buttons/github/learn-more.png?v2" height="28" /></a>
</p>
<br/>


# Actions

[![](https://github.com/secrethub/actions/workflows/.github/workflows/main.yml/badge.svg)](https://github.com/secrethub/actions/actions)
[![](https://img.shields.io/github/release/secrethub/actions.svg)](https://github.com/secrethub/actions/releases/latest)
[![](https://img.shields.io/badge/chat-on%20discord-7289da.svg?logo=discord)](https://discord.gg/NWmxVeb)

> [SecretHub](https://secrethub.io) is a secrets management tool that works for every engineer. Securely provision passwords and keys throughout your entire stack with just a few lines of code.

No more copy-pasting sensitive values into a GUI. Securely load secrets into GitHub Actions and sync them automatically using SecretHub.

This Action is officially supported and actively maintained by SecretHub, but community contributions are very welcome. 

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

## Credential

The example above passes the `SECRETHUB_CREDENTIAL` environment variable. This credential is used to authenticate to SecretHub and decrypt your secrets.

You can obtain a credential by creating a [service account](https://secrethub.io/docs/reference/cli/service). Service accounts are completely separate accounts from your personal account, which means you can [manage their access](https://secrethub.io/docs/reference/cli/acl/) separately and you can identify them in the [audit log](https://secrethub.io/docs/reference/cli/audit/).

After you've obtained a credential for SecretHub, you [store it in a GitHub secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository), so that it can be fetched in your action as shown above.
