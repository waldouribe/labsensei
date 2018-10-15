class ContactMailer < ActionMailer::Base
  default from: "uribe.fache@gmail.com"
  def landing_message(contact)
    @contact = contact
    mail to: 'uribe.fache@gmail.com', subject: "Contacto por formulario"
  end
end