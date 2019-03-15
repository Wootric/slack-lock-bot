# Slack Lock Bot

## Setup

- Setup your bot `http://slack.com/services/new/bot`
- Run `bin/setup`
- Set `SLACK_API_TOKEN` inside of `.env`
- Run `foreman start`
- Invite your bot to a channel

## Deploy to Heroku

- Create an app on Heroku
- Add your heroku remote `git remote add heroku https://git.heroku.com/your-slack-bot.git`
- Run `bin/deploy`
