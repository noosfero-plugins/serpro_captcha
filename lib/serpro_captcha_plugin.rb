class SerproCaptchaPlugin < Noosfero::Plugin

  def self.plugin_name
    _('Serpro\'s captcha plugin')
  end

  def self.plugin_description
    _("Provides a plugin to Serpro's captcha infrastructure.")
  end

  def self.api_mount_points
    [SerproCaptchaPlugin::API ]
  end

  def verify_captcha(*args)
    remote_ip = args[0]
    params = args[1]
    environment = args[2]
    scv = SerproCaptchaVerification.new
    return scv.verify_serpro_captcha(environment.serpro_captcha_client_id, params[:txtToken_captcha_serpro_gov_br], params[:captcha_text], environment.serpro_captcha_verify_uri)
  end

end
