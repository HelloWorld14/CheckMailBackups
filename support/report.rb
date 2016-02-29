require 'net/http'

class SendReport
  # 'http://192.168.4.81/backups'
  HOST = 'http://localhost:3000'

  def initialize(options={})
    @uri = URI(HOST + '/backups/cobian_backups')
    @auth_token = '78b7794e6d8c639b44da07491591a24d78f097a8468a5eef36aa3f3af4d5a71f21f29419a18fa8eb5e42bc95042c04f5137959cf0bee22bf7eecdf94dcce7176'
    @params = options
    send_report
  end

  def send_report
    request_body = {auth_token: @auth_token}.merge(@params)
    Net::HTTP.post_form(@uri, request_body)
  end
end

SendReport.new(success_tasks: 1, fail_tasts: 1, server_name: 'vodka_server', email_body: "FileBody")

