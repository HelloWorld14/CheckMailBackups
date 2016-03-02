require 'rspec'
require_relative "../support/parse_mail.rb"

describe ParseBody do
  let(:body) { File.open("#{Dir.pwd}/spec/fixtures/test.txt").read }  

  before { @report = ParseBody.new(body) }

  it 'Should correct calculate success and fail tasks count' do
    expect(@report.success_tasks).to eq('2')
    expect(@report.fail_tasks).to eq('1')
  end
end