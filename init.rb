require 'mail' 

Mail.defaults do
  retriever_method :imap, :address    => "imap.timeweb.ru",
                          :port       => 993,
                          :user_name  => '<secret>',
                          :password   => '<secret>',
                          :enable_ssl => true
end

email = Mail.last
puts email.body.decoded