class KioskController < ApplicationController
  before_action :authenticate_kiosk!, only: [:show]
  layout "application"

  def play
  end

  def index
    @kiosk = Kiosk.create!
  end

  def show
    @videos = Kiosk.find(params[:id]).playable.resolve
    @kiosk = Kiosk.find(params[:id])
  
    render layout: "kiosk"
  end

  def authenticate
    @kiosk = Kiosk.find(params[:id])
    user_kiosk = UserKiosk.where(kiosk: @kiosk).first

    session[:kiosk_auth] = user_kiosk.auth_token
    @kiosk.code = nil
    @kiosk.save!
    
    redirect_to kiosk_path(@kiosk)
  end

  private

  def authenticate_kiosk!
    if(!session[:kiosk_auth])
      redirect_to kiosk_index_path
    elsif(UserKiosk.where(kiosk: kiosk, auth_token: session[:kiosk_auth]).count == 0)
      session[:kiosk_auth] = nil
      redirect_to kiosk_index_path
    end
  end

  def kiosk
    @kiosk ||= Kiosk.find(params[:id])
  end
end