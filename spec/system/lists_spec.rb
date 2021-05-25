# frozen_string_literal: true

require 'rails_helper'



　神山記述の内容

describe "投稿のテスト" do
  let!(:list) { create(:list, title:'hoge', body:'body')}
  describe "トップ画面(top_path)のテスト" do
    before do
      root_path #正解 visit root_path
    end
    context "表示の確認" do
      it "トップ画面(top_path)に「ここはTopページです」が表示されているか" do
        expect(page).to have_content 'ここはTopページです'
      end
      it "top_pathが/topであるか" do
        expect(current_path).to eq('/top')
      end
    end
  end

  describe "投稿画面のテスト" do
    before do
      todolists_path #正解 visit todolists_new_path
    end
    context "表示の確認" do
      it "todolists_new_pathが/todolists/newであるか" do
        expect(todolists_new_path).to eq ('/todolists/new') #正解 expect(current_path)
      end
      it "投稿ボタンが表示されているか" do
        expect(page).to have_button '投稿'
      end
    end

    context "投稿処理のテスト" do
      it "投稿後のリダイレクト先は正しいか" do
        expect(page).to have_link ('/lists')
        # 正解
        # fill_in 'list[title]', with: Faker::Lorem.characters(number:5)
        # fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
        # click_button '投稿'
        # expect(page).to have_current_path todolist_path(List.last)
      end
    end
  end

  describe "一覧画面のテスト" do
    before do
      lists_path # visit todolists_path
    end
    context "一覧の表示とリンクの確認" do
      it "一覧表示画面に投稿されたもの表示されているか" do
        fill_in 'list[title]', with: Faker::Lomen.characters(number:10)
        fill_in 'list[body]', ith: Faker::Lomen.characters(number:30)
        click_button '投稿'
        expect(page).to have_content 'successfully'
        # expect(page).to have_content list.title
        # expect(page).to have_link list.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      list_path # visit todolist_path(list)
    end
    # 抜けてた
    # context '表示の確認' do
    #   it '削除リンクが存在しているか' do
    #     expect(page).to have_link '削除'
    #   end
    #   it '編集リンクが存在しているか' do
    #     expect(page).to have_link '編集'
    #   end
    # end

    context "表示のテスト" do
      it "削除リンクが存在しているか" do
        expect(page).to have_link('list_delete_path')
      end
    end
    context "リンクの遷移先の確認" do
      it "編集の遷移先は編集画面か" do
        click_button '編集'
        expect(current_path).to eq ('/list/.:id/edit')
        # 正解
    #     edit_link = find_all('a')[3]
    #     edit_link.click
    #     expect(current_path).to eq('/todolists/' + list.id.to_s + '/edit')
      end
    end
    context "list削除のテスト" do
      it "listの削除" do
        expect { list.destroy }.to change{ list.count }.by(-1)
        # 正解
        # expect{ list.destroy }.to change{ List.count }.by(-1)
      end
    end
  end

  describe "編集画面のテスト" do
    before do
      list_path(params).edit    # visit edit_todolist_path(list)
    end
    context "表示の確認" do
      it "編集前のタイトルと本文がフォームに表示(セット)されている" do
        fill_in 'list[title]'
        fill_in 'list[body'
        # expect(page).to have_field 'list[title]', with: list.title
        # expect(page).to have_field 'list[body]', with: list.body
        
      end
      it "保存ボタンが表示される" do
        expect(page).to have_button '保存'
      end
    end
    context "更新処理に関するテスト" do
      it "更新後のリダイレクト先は正しいか" do
        click_button '更新'
        expect(current_path).to eq '/list/.:id/show'
        # fill_in 'list[title]', with: Faker::Lorem.characters(number:5)
        # fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
        # click_button '保存'
        # expect(page).to have_current_path todolist_path(list)
      end
    end
  end

end

