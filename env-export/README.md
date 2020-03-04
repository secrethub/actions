# secrethub/actions/env-export

The `env-export` action reads all referenced secrets from environment variables prefixed by `secrethub://` and secrets specified in the `secrethub.env` template file, and makes the secret values available as environment variables to the rest of the job.

It leverages GitHub's output masking feature, so if secret values are (accidentally) logged, they get replaced with `*****`.

## Usage

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
        uses: Ilshidur/action-slack@2.0.1 # this Action expects SLACK_WEBHOOK to be set
        with:
          args: Sent from GitHub Actions with secrets from SecretHub 🔑
```
