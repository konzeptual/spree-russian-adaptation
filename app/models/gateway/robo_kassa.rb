class Gateway::RoboKassa < Gateway
  preference :login, :string
  preference :password1, :password  
  preference :password2, :password
  
  def provider_class
    ActiveMerchant::Billing::RoboKassaGateway
  end 
  
  def payment_button(params1, params2)
    provider.payment_button(params1, params2)
  end

  def payment_kassa(params1, params2)
    provider.payment_kassa(params1, params2)
  end

  def method_type
    'robo_kassa'
  end

end
