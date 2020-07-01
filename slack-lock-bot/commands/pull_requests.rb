class SlackLockBot::Commands::PullRequests < SlackRubyBot::Commands::Base
  command 'prs' do |client, data, _match|
    org = 'Wootric'
    gh_client = Octokit::Client.new(
      access_token: ENV['GITHUB_AUTH_TOKEN']
    )
    gh_client.auto_paginate = true

    members = gh_client.organization_members(org).map(&:login)
    repos = gh_client.organization_repositories(org)
                     .select { |r| r.open_issues_count.positive? }
                     .map(&:name)

    prs = []

    repos.each do |repo|
      gh_client.issues("#{org}/#{repo}").each do |issue|
        prs << issue if issue.pull_request && members.include?(issue.user.login)
      end
    end

    prs = prs.map do |pr|
      labels = if pr.labels.empty?
                 'needs review'
               else
                 pr.labels.map(&:name).join(', ')
               end
      days_open = ((Time.now.getutc - pr.created_at).to_i / 86_400).to_i

      {
        user: pr.user.login,
        url: pr.html_url.sub('https://', ''),
        labels: labels,
        days_open: days_open
      }
    end

    prs = prs.sort_by { |pr| pr[:days_open] }

    printer = TablePrint::Printer.new(
      prs,
      [
        {
          user: {
            display_name: 'USER'
          }
        },
        {
          url: {
            width: 100
          }
        },
        {
          labels: {
            width: 100
          }
        },
        {
          days_open: {
            display_name: 'DAYS OPEN'
          }
        }
      ]
    )

    text = ''

    text << "```\n"
    text << printer.table_print
    text << "```\n"

    client.say(
      channel: data.channel,
      text: text
    )
  end
end
