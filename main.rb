# encoding: utf-8;

require 'mail'
require 'yaml'

require_relative 'support/parse_mail'
require_relative 'support/report'


config = YAML.load_file('/home/deploy/CheckMailBackups/config.yml')

Mail.defaults do
  retriever_method :imap, :address    => config["smtp"],
                          :port       => config["port"],
                          :user_name  => config["login"],
                          :password   => config["password"],
                          :enable_ssl => config["enable_ssl"]
end

#email = Mail.first
#puts email.subject


loop do
  p 'ПАРСИМ'
  emails = Mail.find(keys: ['NOT', 'SEEN'])

  emails.each do |email|
    body = ParseBody.new(email.body.decoded.to_s.force_encoding('UTF-8'))
    puts body
    report = ParseBody.new(body)

    report.tasks.each do |task|
      SendReport.new(
          server_name: email.subject.scan(/\(.*?\)/),
          task_name: task[:name],
          errors_count: task[:errors_count],
          status: task[:status],
          client_id: email.subject.scan(/.*?\s/)[0]
      )
    end
  end

  sleep 60
end
