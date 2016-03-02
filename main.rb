# encoding: utf-8;

require 'mail'
require 'yaml'

require_relative 'support/parse_mail'
require_relative 'support/report'

config = YAML.load_file('config.yml')

Mail.defaults do
  retriever_method :imap, :address    => config["smtp"],
                          :port       => config["port"],
                          :user_name  => config["login"],
                          :password   => config["password"],
                          :enable_ssl => config["enable_ssl"]
end

loop do
  p 'ПАРСИМ'
  emails = Mail.find(keys: ['NOT', 'SEEN'])

  emails.each do |email|
    report = ParseBody.new(email.body.decoded.to_s.force_encoding('UTF-8'))

    if email.parts && email.parts[0] != nil
      body = email.parts[0]
    else
      body = email.body
    end

    SendReport.new(
        success_tasks: report.success_tasks,
        fail_tasks: report.fail_tasks,
        email: body.decoded.to_s,
        server_name: email.subject
    )
  end

  sleep 60
end
