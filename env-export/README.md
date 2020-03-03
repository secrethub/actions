# secrethub/actions/env-export

The `env-export` action reads all referenced secrets from environment variables prefixed by `secrethub://` and secrets specified in the `secrethub.env` template file, and makes the secret values available as environment variables to the rest of the job.

It leverages GitHub's masking feature, so when secret values are (accidentally) logged, they get replaced with `*****`.

## Usage

```yml
on: push
jobs:
  notify-slack:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: secrethub/actions/env-export@master
        env:
          SECRETHUB_CREDENTIAL: ${{ secrets.SECRETHUB_CREDENTIAL }}
          SLACK_WEBHOOK: secrethub://company/app/slack/webhook
      - name: Print environment with masked secrets
        run: printenv
      - name: Notify Slack
        uses: Ilshidur/action-slack@master # this Action expects SLACK_WEBHOOK to be set
        with:
          args: Sent from GitHub Actions with secrets from SecretHub 🔑
```
