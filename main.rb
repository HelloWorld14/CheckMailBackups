# encoding: utf-8;

require_relative 'support/parse_mail'
require 'mail'

Mail.defaults do
  retriever_method :imap, :address    => "imap.timeweb.ru",
                          :port       => 993,
                          :user_name  => '<SECRETS>',
                          :password   => '<SECRETS>',
                          :enable_ssl => true
end

loop do
  emails = Mail.find(keys: ['NOT', 'SEEN'])

  emails.each do |email|
    report = ParseBody.new(email.body.decoded.to_s.force_encoding('UTF-8'))
    p report.success_tasks
    p report.fail_tasks
  end

  sleep 60
end
#report = ParseBody.new(email.body.decoded)
#puts report.success_tasks
#puts report.fail_tasks