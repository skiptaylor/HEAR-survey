
# get '/users/:user_id/surveys/new/?' do
#   auth_user
#   @user = User.get(params[:user_id])
#   @survey = Survey.new
#
#   erb :'/questions/question0'
# end
#
# post '/users/:user_id/surveys/new/?' do
#   auth_user
#   user = User.get(params[:user_id])
#   survey = Survey.create(
#     :user_id      => params[:user_id],
#     :loyalty      => params[:loyalty],
#     :duty         => params[:duty],
#     :respect      => params[:respect],
#     :service      => params[:service],
#     :honor         => params[:honor],
#     :integrity    => params[:integrity],
#     :courage      => params[:courage],
#     :service      => params[:service],
#     :importance   => params[:importance],
#     :thoughts1    => params[:thoughts1],
#     :thoughts2    => params[:thoughts2],
#     :rolemodel    => params[:rolemodel]
#   )
#
#   redirect "/users/#{user.id}/surveys/#{survey.id}/?"
# end
#
# get '/users/:user_id/surveys/:id/?' do
#   auth_user
#   @user = User.get(params[:user_id])
#   @survey = Survey.get(params[:id])
#
#   erb :'/questions/question0'
# end
#
# get '/users/:user_id/surveys/:id/edit/?' do
#  auth_user
#  @user = User.get(params[:user_id])
#  @survey = Survey.get(params[:id])
#  erb :'/questions/question0_edit'
# end
# post '/users/:user_id/surveys/:id/edit/?' do
#  auth_user
#  user = User.get(params[:user_id])
#  survey = Survey.get(params[:id])
#  survey.update(
#    :user_id      => params[:user_id],
#    :loyalty      => params[:loyalty],
#    :duty         => params[:duty],
#    :respect      => params[:respect],
#    :service      => params[:service],
#    :honor         => params[:honor],
#    :integrity    => params[:integrity],
#    :courage      => params[:courage],
#    :service      => params[:service],
#    :importance   => params[:importance],
#    :thoughts1    => params[:thoughts1],
#    :thoughts2    => params[:thoughts2],
#    :rolemodel    => params[:rolemodel]
#  )
#  redirect "/users/#{user.id}/surveys/#{survey.id}/?"
# end
