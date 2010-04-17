# -*- coding: utf-8 -*-
class RoboKassaController < Spree::BaseController
  before_filter :load_robokassa
  
  def show
    load_order_by_number(params[:id])
  end

  def result
    if @robo_kassa.result?(params)
      load_order_by_number('R' + params[:InvId])
      render :text => "OK#{params[:InvId]}", :status => :ok 
    else
      
      render :text => "Signature is invalid", :status => :ok
    end 
  end

  def success
    if  load_order_by_number('R' + params[:InvId].to_s) 
      flash[:error] = 'Заказ R#{params[:InvId].to_s} не найден.'
    elsif @robo_kassa.success?(params)
      payment = Payment.new(:payable => @order, :amount => params[:OutSum])
      payment.save
      flash[:notice] = 'Платёж принят, спасибо!'
    else
      flash[:error] = 'Платёж не прошёл проверку подписи.'
    end
    redirect_to @order ? order_url(@order.number) : root_url
  end
  
  def fail
    load_order_by_number('R' + params[:InvId])
    flash[:error] = 'Платёж не завершен или отменён.'
    redirect_to @order ? order_url(@order.number) : root_url
  end

  private 

  def accurate_title
    "Платежи"
  end
  
  def load_order_by_number(number)
    @order = Order.find_by_number(number)
    # При редиректе мне выдавалась ошибка:
    # Please note that you may only call render at most once per action. Also note that neither redirect nor render terminate
    # execution of the action, so if you want to exit an action after redirecting, you need
    # to do something like "redirect_to(...) and return".)

    # flash[:error] = "Заказ с номером #{number} не найден."
    # redirect_to root_url
  end
  
  def load_robokassa
    if not Gateway.current 
      render :text => "Ошибка конфигурации: Не выбран текущий платежный гейт.",
      :status => '500'
    elsif Gateway.current.method_type != 'robo_kassa'
      render :text => "Ошибка конфигурации: Текущий гейт должен быть 'робокасса'. Сейчас #{Gateway.current.type}",
      :status => '500'
    else
      @robo_kassa = Gateway.current.provider 
    end
  end

end
