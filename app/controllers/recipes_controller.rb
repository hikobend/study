class RecipesController < ApplicationController
  # ログインしていない人のアクセス制限をかける
  # deviseを使うと、導入できるヘルパーauthenticate_user!
  # authenticate_user!とかくと、ログインしていない人は全てのアクションにアクセスできない
  # ただしindexアクション飲みはアクセスできる
  # user.contorllerにも書く
  before_action :authenticate_user!, expect: [:index]

  # recipeの一覧画面を表示する
  def index
    # データが複数あるので、
    @recipes = Recipe.all
  end

  # recipeの詳細画面を作成
  def show
    # urlのところからidの番号を取ってくる
    @recipe = Recipe.find(params[:id])
  end

  #新規投稿ページの作成 
  def new
    # Recipeモデルから空のモデルをもってくる
    @recipe = Recipe.new
  end

  # データベースに保存するアクションを作成
  def create
    @recipe = Recipe.new(recipe_params)
    # 誰が投降したのかをいれる
    # user_idは投稿した人。ログインしている人のidはcurrent_user.id。user_idのところにcurrent_user.idを入れる
    @recipe.user_id = current_user.id
    # validateをつけることによって保存される時と、されないときがある
    # saveでデータベースに保存する
    if @recipe.save
    # レシピの詳細画面に遷移したい
    # 今投稿された@recipeの詳細画面に遷移
    # フラッシュメッセージを作成する
      redirect_to recipe_path(@recipe), notice: '投稿に成功しました'
    else
      # アクションを返さずに、そのビューを返す
      # newアクションを返さずに、recipes/new.html.erbに行く
      render :new
    end
  end

  # 編集ページ作成
  def edit
    @recipe = Recipe.find(params[:id])
    #  recipeに紐づいているユーザーとログインしているユーザーが等しくなかったら、
    if @recipe.user != current_user
      # レシピの一覧画面に遷移するようにする。警告文も流れるようにする。
      redirect_to recipes_path, alert: '不正なアクセスです'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    # アップデートする
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: '更新に成功しました'
    else
      render :edit
    end
  end

  # 削除するモノアクションを設定
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    # レシピの一覧画面に遷移する
    redirect_to recipes_path
  end
  # セキュリティ面を考慮して、
  private
    def recipe_params
      params.require(:recipe).permit(:title, :body, :image)
    end
end
