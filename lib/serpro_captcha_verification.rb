class SerproCaptchaVerification

  # return true or a hash with the error
  # :user_message, :status, :log_message, :javascript_console_message
  def verify_serpro_captcha(client_id, token, captcha_text, verify_uri)
    msg_icve = _('Internal captcha validation error')
    msg_esca = 'Environment serpro_captcha_plugin_attributes'
    return hash_error(msg_icve, 500, nil, "#{msg_esca} verify_uri not defined") if verify_uri.nil?
    return hash_error(msg_icve, 500, nil, "#{msg_esca} client_id not defined") if client_id.nil?
    return hash_error(_("Error processing token validation"), 500, nil, _("Missing Serpro's Captcha token")) unless token
    return hash_error(_('Captcha text has not been filled'), 403) unless captcha_text
    uri = URI(verify_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path)
    verify_string = "#{client_id}&#{token}&#{captcha_text}"
    request.body = verify_string
    body = http.request(request).body
    return true if body == '1'
    return hash_error(_("Internal captcha validation error"), 500, body, "Unable to reach Serpro's Captcha validation service") if body == "Activity timed out"
    return hash_error(_("Wrong captcha text, please try again"), 403) if body == '0'
    return hash_error(_("Serpro's captcha token not found"), 500) if body == '2'
    return hash_error(_("No data sent to validation server or other serious problem"), 500) if body == -1
    #Catches all errors at the end
    return hash_error(_("Internal captcha validation error"), 500, nil, "Error validating Serpro's captcha service returned: #{body}")
  end

  def hash_error(user_message, status, log_message=nil, javascript_console_message=nil)
    {user_message: user_message, status: status, log_message: log_message, javascript_console_message: javascript_console_message}
  end

end
