class DeviseMailer < Devise::Mailer
  layout 'email'
  def params
  end
end