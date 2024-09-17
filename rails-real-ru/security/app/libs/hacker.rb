# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      registration_uri = URI('https://rails-collective-blog-ru.hexlet.app/users/sign_up')
      submitting_uri = URI('https://rails-collective-blog-ru.hexlet.app/users')

      response = Net::HTTP.get_response(registration_uri)
      cookie = response['set-cookie'].split('; ')[0]
      html = Nokogiri::HTML(response.body)

      authenticity_token = html.at('input[@name="authenticity_token"]')
      request_body = { 
        'authenticity_token' => authenticity_token['value'],
        'user[email]' => email,
        'user[password]' => password,
        'user[password_confirmation]' => password
      }

      response = Net::HTTP.post URI(submitting_uri),
            URI.encode_www_form(request_body),
               "Content-Type" => "application/x-www-form-urlencoded",
               "Cookie" => cookie

      if response.code == '302'
        print "Registration is complete"
      else
        print "Unexpected error"
      end
      response.code
    # END
    end
  end
end
