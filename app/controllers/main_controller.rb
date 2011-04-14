class MainController < ApplicationController
  def index
    session.set_trans_data(session['sid'], 'message', 'Hello from Rails!')
  end

  def wizard
    if params[:fid] # back
      form_data = session.get_form_data(params[:fid])
      @address = Address.new(form_data.merge(:fid => params[:fid]))
    else # next
      @address = Address.new(:fid => (@fid = session.new_form))
    end
  end

  def wizard_step2
    if params[:fid] # back
      form_data = session.get_form_data(params[:fid])
      @address = Address.new(form_data.merge(:fid => params[:fid]))
    else # next
      form_data = session.get_form_data(params[:address][:fid])
      @address = form_data ? Address.new(form_data.merge(params[:address])) : Address.new(params[:address])
      session.set_form_data(@address.fid, @address.to_hash)
    end
  end

  def wizard_step3
    @address = Address.new(params[:address])
    session.set_form_data(@address.fid, session.get_form_data(@address.fid).merge(@address.to_hash))
    redirect_to wizard_path(:fid => @address.fid) and return if params[:commit] == 'Previous'
    @address.save
  end
  
  def nonce
    nc = session.create_nonce
    @address = Address.new(:nonce => nc)
  end
  
  def check_nonce
    @address = Address.new(params[:address])
    @success = session.nonce_still_valid?(@address.nonce)
    @address.save if @success
  end
end
