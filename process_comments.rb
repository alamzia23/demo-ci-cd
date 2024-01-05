require 'octokit'
          client = Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
          comments = []
          client.pull_requests('${{ github.repository }}', state: 'closed').each { |pr|
            client.pull_request_comments('${{ github.repository }}', pr.number).each { |comment|
              if comment[:body].downcase.include?(ENV['TESTED'].downcase)
                comments << comment
              end
            }
          }
          # Output the list using GitHub Actions Outputs
          outputs.comments = comments.map { |comment| comment[:body] }.join("\n")
