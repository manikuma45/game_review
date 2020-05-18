class Admin::GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    # binding.pry
    @q = Game.ransack(params[:q])
    @games = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.new(game_params)
    if params[:back]
      render :new
    else
      if @game.save
        redirect_to game_path(@game.id), notice: "ゲームを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    @comments = @game.comments
    @comment = @game.comments.build
    @favorite = current_user.favorites.find_by(game_id: @game.id)
    @own = current_user.owns.find_by(game_id: @game.id)
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game.id), notice: "ゲームを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path, notice:"ゲームを削除しました！"
  end

  private

  def game_params
    params.require(:game).permit(:title, :company, :genre, :price, :released_at, :story, :icon, :icon_cache)
  end

  def search_params
    params.require(:q).permit(:title_or_company_cont, :price_gteq, :price_lt, {:genre_in => []}, :released_at_gteq, :released_at_lteq)
  end

  def set_game
    @game = Game.find(params[:id])
  end

end