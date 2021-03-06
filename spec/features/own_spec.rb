require 'rails_helper'

RSpec.describe '持ってる機能', type: :feature do
  before do
    @game = Game.create(title: "title", company: "company", price: 5000, genre: 5, released_at: "2020-05-05", story: "story", icon: "icon_URL")
    @user= User.new(name: "name", introduce: "introduce", icon: "icon_URL", admin: false, email: "test@e.mail", password: "password")
    # @user.skip_confirmation!
    @user.save  

    # ログインします。
    visit new_user_session_path
    fill_in "メールアドレス", with: @user.email
    fill_in "パスワード", with: @user.password
    find(".login_button").click
  end

  feature 'ゲーム詳細画面' do
    context '持ってるボタンを押した場合' do
      it '持ってる登録される（解除ボタンが表示される）こと' do
        visit game_path(@game.id)
        click_on '持ってる'
        expect(page).to have_content "持ってるを解除する"
      end
    end
  end
end