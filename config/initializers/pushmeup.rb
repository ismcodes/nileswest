GCM.host = 'https://android.googleapis.com/gcm/send'
# https://android.googleapis.com/gcm/send is default

GCM.format = :json
# :json is default and only available at the moment

GCM.key = "AIzaSyAw-i_sXbC1rYzoJjOKYnS7B-mV0jlfF_o"
# this is the apiKey obtained from here https://code.google.com/apis/console/

APN = Houston::Client.production
APN.certificate = File.read("config/initializers/prod_cert.pem")
APN.passphrase = ""
