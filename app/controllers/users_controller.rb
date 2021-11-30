class UsersController < ApplicationController
  
  # ログインしていない人のアクセス制限をかける
  # deviseを使うと、導入できるヘルパーauthenticate_user!
  # authenticate_user!とかくと、ログインしていない人は全てのアクションにアクセスできない
  # ただしindexアクション飲みはアクセスできる
  before_action :authenticate_user!, expect: [:index]
  # ユーザーの一覧を表示する
  def index
    # userモデルから全てのデータをとってくる
    # @usersの中に入れる 
    # 複数のデータを格納するときは、@を複数形にする
    @users = User.all 
  end

  # 詳細画面を作成
  def show
    # １人の情報だけをparams[:id]から持ってくる
    @user = User.find(params[:id])
  end

  # 編集画面を作成
  def edit
    @user = User.find(params[:id]) 
    #  recipeに紐づいているユーザーとログインしているユーザーが等しくなかったら、
    if @recipe.user != current_user
      # レシピの一覧画面に遷移するようにする。警告文も流れるようにする。
      redirect_to recipes_path, alert: '不正なアクセスです'
    end
  end

  # ユーザーの情報を更新するアクションを作成
  def update
    # １人の情報だけをparams[:id]から持ってくる
    @user = User.find(params[:id])
    # userをuser_paramsでアップデートする user_paramsを下で定義
    if @user.update(user_params)
    # 更新できたら、ユーザーの詳細画面に移動する
      redirect_to user_path(@user), notice: '更新に成功しました'
    else
      render :edit 
    end
  end

  # UserControllerの中でしか定義しない
  # セキュリティの観点から、外部から情報を取り出せないようにする
  private
  def user_params
    # userのusernameとemailとprofileとprofile_imageを更新することを許可する 
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end

end