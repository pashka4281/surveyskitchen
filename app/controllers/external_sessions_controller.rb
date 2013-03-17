class ExternalSessionsController < ApplicationController

  def callback
  	send(params[:provider])
  end

  protected

  def facebook
    # render text: auth_hash.to_yaml and return
    @user = connect_provider(:facebook, auth_hash, current_user)
    common_render(:facebook)
  end
  
  def twitter
    @user = connect_provider(:twitter, auth_hash, current_user)
    common_render(:twitter)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def common_render(provider)
    redirect_to :root, alert: @error and return if @error
    if(@user.persisted?)
      if current_user
        redirect_to :profile, notice: "Successfully connected to #{provider.to_s.titleize}"
      else
        flash[:notice] = "Successfully authenticated with #{provider.to_s.titleize}."
        if :twitter == provider && @user.new_record?
          flash[:notice] += "Your Email is automatically set to #{@user.email}. You can change it in profile settings."
        end 
        session[:user_id] = @user.id
	    redirect_to :dashboard
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_registration_path
    end    
  end



  def connect_provider(provider, auth_hash, current_user)
    auth = Authentication.find_by_provider_and_uid(provider.to_s, auth_hash.uid)
    unless auth
      unless current_user
        user_params = map_auth_hash_for_provider(auth_hash, provider)
        user = User.create(user_params)
        # user.reload
        # user.save
      else
        user = current_user
      end
      auth = Authentication.create_from_oauth(auth_hash, user, provider.to_s)
    end
    auth.user
  end

  private

  def map_auth_hash_for_provider(auth_hash, provider)
    case provider
    when :twitter
      { full_name: auth_hash.info.name,
        # remote_avatar_url: auth_hash.info.image,
        password: friendly_token(),
        email: "#{auth_hash.info.nickname}@none.com" }
    when :facebook
      { full_name: auth_hash.extra.raw_info.name,
        email: auth_hash.info.email,
        # remote_avatar_url: "http://graph.facebook.com/#{auth_hash.extra.raw_info.id}/picture?type=large",
        password: friendly_token()  }
    end
  end

  def friendly_token
  	SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

end
