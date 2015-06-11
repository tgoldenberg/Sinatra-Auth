get '/login' do
 erb :'auth/login'
end

get '/signup' do
  erb :'auth/signup'
end

post '/signup' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/cats'
  end
end

get '/cats' do
  erb :cats
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if !@user.nil? && @user.password == params[:password]
    session[:user_id] = @user.id
    p session
    redirect '/'
  else
    @messages = ["User name and password do not match"]
    erb :'auth/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect back
end
