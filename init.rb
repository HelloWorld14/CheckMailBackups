require 'mail' 

Mail.defaults do
  retriever_method :imap, :address    => "imap.timeweb.ru",
                          :port       => 993,
                          :user_name  => '<SECRET>',
                          :password   => '<SECRET>',
                          :enable_ssl => true
end

email = Mail.first