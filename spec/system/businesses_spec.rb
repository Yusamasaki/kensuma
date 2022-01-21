require 'rails_helper'

RSpec.describe 'Businesses', type: :system do
  let(:user) { build(:user) }

  let(:business) { build(:business, user: user) }

  describe '事業所CRUD' do
    describe 'ログインするユーザーの事業所が登録されていない' do
      before(:each) do
        user.skip_confirmation!
        user.save!
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it '事業所新規作成' do
        # フォーム内は現在defaultでデータが入っているためfill_inはスキップ
        click_button '登録'
        expect(page).to have_current_path users_dash_boards_path, ignore_query: true
        expect(page).to have_content 'DashBoard'
      end
    end

    describe 'ログインするユーザーの事業所が登録されている' do
      before(:each) do
        user.skip_confirmation!
        user.save!
        # 事業所登録
        business.save!
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'DashBoard画面が表示' do
        expect(page).to have_current_path users_dash_boards_path, ignore_query: true
        expect(page).to have_content 'DashBoard'
      end

      it '事業所編集画面の表示' do
        visit edit_users_business_path
        expect(page).to have_current_path edit_users_business_path, ignore_query: true
        expect(page).to have_content '事業所編集'
      end

      it '事業所詳細画面の表示' do
        visit users_business_path
        expect(page).to have_current_path users_business_path, ignore_query: true
        expect(page).to have_content '事業所詳細'
      end
    end
  end
end
