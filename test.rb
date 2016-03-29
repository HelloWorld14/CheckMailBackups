# encoding: utf-8;

require 'mail'
require 'yaml'

require_relative 'support/parse_mail'
require_relative 'support/report'

subject = "40"

body = File.open('spec/fixtures/sql.txt').read

if subject =~ /\d*^/
  @type = 'SQL'
  @client = subject
  @body = body

  body.split("\n").each do |s|
    @status = s.gsub(/СОСТОЯНИЕ:/, "").strip if s=~/СОСТОЯНИЕ:/
  end
end



