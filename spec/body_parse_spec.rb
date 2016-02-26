require 'rspec'
require_relative "../parse_mail.rb"

describe ParseBody do
  describe 'success methods' do
    let(:mail_body) { File.open("#{Dir.pwd}/spec/fixtures/all_success.txt").read }

    it 'Should return info about two success tasks' do
      out = ParseBody.new(mail_body)

      expect(out.success_tasks).to eq("Заданий выполнено: 2")
    end
  end


  describe "fail methods" do
    let(:mail_body) { File.open("#{Dir.pwd}/spec/fixtures/all_fail.txt").read }

    it 'Should return info about two fail tasks' do
      out = ParseBody.new(mail_body)

      expect(out.fail_tasks).to eq("Заданий провалено: 1")
    end
  end

  describe "success and fail" do
    let(:mail_body) { File.open("#{Dir.pwd}/spec/fixtures/success_and_fail.txt").read }

    it 'Should return info about two fail tasks' do
      out = ParseBody.new(mail_body)

      expect(out.success_tasks).to eq("Заданий выполнено: 2")
      expect(out.fail_tasks).to eq("Заданий провалено: 1")
    end
  end
end