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
    if emails.subject =~ /\d*^/
      @client = emails.subject
      @auth_token = '78b7794e6d8c639b44da07491591a24d78f097a8468a5eef36aa3f3af4d5a71f21f29419a18fa8eb5e42bc95042c04f5137959cf0bee22bf7eecdf94dcce7176'
      body = email.body.decoded.to_s.force_encoding('UTF-8')

      body.split("\n").each do |s|
        @status = s.gsub(/СОСТОЯНИЕ:/, "").strip if s=~/СОСТОЯНИЕ:/
      end

      HOST = 'http://192.168.4.81'
      @uri = URI(HOST + '/backups/cobian_backups')
      request_body = {body: body, client: @client, auth_token: @auth_token}

      Net::HTTP.post_form(@uri, request_body)

    else
      report = ParseBody.new(email.body.decoded.to_s.force_encoding('UTF-8'))

      report.tasks.each do |task|
        SendReport.new(
            server_name: email.subject.scan(/\(.*?\)/),
            task_name: task[:name],
            errors_count: task[:errors_count],
            status: task[:status],
            client_id: email.subject.scan(/.*?\s/)[0],
            body: email.body.decoded.to_s.force_encoding('UTF-8')
        )
      end
    end

  end

  sleep 60
end
