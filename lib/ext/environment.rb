require_dependency 'environment'

class Environment

  #Captcha settings
  settings_items :serpro_captcha_plugin, :type => ActiveSupport::HashWithIndifferentAccess, :default => {}

#  settings_items :verify_uri, :type => :string, :default => 'http://captcha.servicoscorporativos.serpro.gov.br/captchavalidar/1.0.0/validar'
#  settings_items :serpro_client_id, :type => :string, :default => 'fdbcdc7a0b754ee7ae9d865fda740f17'

  attr_accessible :serpro_captcha_plugin_attributes, :serpro_captcha_verify_uri, :serpro_captcha_client_id

  def serpro_captcha_plugin_attributes
    self.serpro_captcha_plugin || {}
  end

  def serpro_captcha_verify_uri= verify_uri
    self.serpro_captcha_plugin = {} if self.serpro_captcha_plugin.blank?
    self.serpro_captcha_plugin['serpro_captcha_verify_uri'] = verify_uri
  end

  def serpro_captcha_verify_uri
    self.serpro_captcha_plugin['serpro_captcha_verify_uri']
  end

  def serpro_captcha_client_id= client_id
    self.serpro_captcha_plugin = {} if self.serpro_captcha_plugin.blank?
    self.serpro_captcha_plugin['serpro_captcha_client_id'] = client_id
  end

  def serpro_captcha_client_id
    self.serpro_captcha_plugin['serpro_captcha_client_id']
  end

end
