Warden::Manager.after_authentication do |record|
  if record.admin?
    CUSTOM_LOGGER.info "%s::Sign In::%s::%s" %[record.email, DateTime.now.to_s,
      record.current_sign_in_ip]
  end
end

 Warden::Manager.before_logout do |record|
  if record.admin?
    CUSTOM_LOGGER.info "%s::Sign Out::%s::%s" %[record.email, DateTime.now.to_s,
      record.current_sign_in_ip]
  end
end
