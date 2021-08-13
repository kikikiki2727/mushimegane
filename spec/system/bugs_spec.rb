require 'rails_helper'

RSpec.describe 'Bugs', type: :system do
  let(:user) { create(:user) }
  let(:bug) { create(:bug) }

  describe 'ログイン前' do
    context '一覧ページ' do
      it '害虫の一覧が表示される' do
        bug_list = create_list(:bug, 3)
        visit bugs_path
        expect(page).to have_content bug_list[0].name
        expect(page).to have_content bug_list[1].name
        expect(page).to have_content bug_list[2].name
        expect(current_path).to eq bugs_path
      end
    end

    xcontext '新規作成ページ' do
      it 'ログイン画面にリダイレクトされる' do
        visit new_bug_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end

    context '詳細ページ' do
      let!(:radar_chart) { create(:radar_chart, bug: bug) }

      it '害虫の詳細が表示される' do
        visit bug_path(bug)
        expect(page).to have_content bug.name
        expect(page).to have_content Bug.human_attribute_name(:feature)
        expect(page).to have_content Bug.human_attribute_name(:approach)
        expect(page).to have_content Bug.human_attribute_name(:prevention)
        expect(page).to have_content Bug.human_attribute_name(:harm)
        expect(page).to have_content Bug.human_attribute_name(:feature)
        expect(current_path).to eq bug_path(bug)
      end
    end

    xcontext '編集ページ' do
      it 'ログイン画面にリダイレクトされる' do
        visit new_bug_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    let!(:radar_chart) { create(:radar_chart, bug: bug) }

    before do
      login user
    end

    xcontext '新規作成ページ' do
      it '有効な値を入れると新規作成に成功する' do
        visit new_bug_path
        fill_in 'bug_radar_chart_form[name]', with: '害虫の名前'
        fill_in 'bug_radar_chart_form[feature]', with: '害虫の特徴'
        fill_in 'bug_radar_chart_form[approach]', with: '害虫の駆除方法'
        fill_in 'bug_radar_chart_form[prevention]', with: '害虫の予防方法'
        fill_in 'bug_radar_chart_form[harm]', with: '害虫の実害'
        select '選択してください', from: 'bug_radar_chart_form[size]'
        select '黒', from: 'bug_radar_chart_form[color]'
        select '春', from: 'bug_radar_chart_form[season]'
        # attach_file 'bug_radar_chart_form[image]', "#{Rails.root}/spec/fixtures/images/default.png"
        click_on '登録する'
        expect(page).to have_content '登録しました'
        expect(Bug.count).to eq 2
        expect(current_path).to eq bug_path(Bug.last)
      end

      it '名前を空欄にすると新規作成に失敗する' do
        visit new_bug_path
        click_on '登録する'
        expect(page).to have_content '登録できませんでした'
        expect(page).to have_content '名前を入力してください'
        expect(current_path).to eq bugs_path
      end
    end

    xcontext '編集ページ' do
      let!(:radar_chart) { create(:radar_chart, bug: bug) }
      let(:edit_bug) { create(:bug, user: user) }
      let!(:radar_chart_with_edit_bug) { create(:radar_chart, bug: edit_bug) }

      it '有効な値を入れると更新できる' do
        visit bug_path(edit_bug)
        click_on '編集'
        fill_in 'bug_radar_chart_form[feature]', with: '特徴を更新します'
        select '冬', from: 'bug_radar_chart_form[season]'
        click_on '更新する'
        expect(page).to have_content '更新しました'
        expect(current_path).to eq bug_path(edit_bug)
      end

      it '名前を空欄にすると更新に失敗する' do
        visit edit_bug_path(edit_bug)
        fill_in 'bug_radar_chart_form[name]', with: nil
        click_on '更新する'
        expect(page).to have_content '更新できませんでした'
        expect(page).to have_content '名前を入力してください'
        expect(current_path).to eq bug_path(edit_bug)
      end
    end
  end

  describe '検索機能' do
    let!(:other_bug) { create(:bug) }

    describe 'フリーワード検索' do
      context '検索ワードに「ゴキブリ」を入れて検索する' do
        let!(:name_bug) { create(:bug, feature: 'ゴキブリ') }
        let!(:feature_bug) { create(:bug, feature: 'ゴキブリが嫌いです') }
        let!(:approach_bug) { create(:bug, approach: 'ゴキブリが好きです') }
        let!(:prevention_bug) { create(:bug, prevention: 'ゴキブリが怖いです') }
        let!(:harm_bug) { create(:bug, harm: 'ゴキブリが気持ち悪いです') }

        it '検索ワードの入ったレコードのみ表示される' do
          visit root_path
          find('.navbar-toggler').click
          click_on '検索'
          fill_in 'search[search_word]', with: 'ゴキブリ'
          click_on '検索する'
          expect(page).to have_content name_bug.name
          expect(page).to have_content feature_bug.name
          expect(page).to have_content approach_bug.name
          expect(page).to have_content prevention_bug.name
          expect(page).to have_content harm_bug.name
          expect(page).not_to have_content other_bug.name
        end
      end
    end

    describe 'セレクト検索' do
      before do
        visit root_path
        find('.navbar-toggler').click
        click_on '検索'
      end

      context 'サイズを「small」に指定して検索する' do
        let!(:size_small_bug) { create(:bug, size: 'small') }

        it '指定したサイズを持つレコードのみ表示される' do
          choose 'search_size_small'
          click_on '検索する'
          expect(page).to have_content size_small_bug.name
          expect(page).not_to have_content other_bug.name
        end
      end

      context '色を「white」に指定して検索する' do
        let!(:color_white_bug) { create(:bug, color: 'white') }

        it '指定した色を持つレコードだけ表示される' do
          choose 'search_color_white'
          click_on '検索する'
          expect(page).to have_content color_white_bug.name
          expect(page).not_to have_content other_bug.name
        end
      end

      context '季節を「winter」に指定して検索する' do
        let!(:season_winter_bug) { create(:bug, season: 'winter') }

        it '指定した季節を持つレコードだけ表示される' do
          choose 'search_season_winter'
          click_on '検索する'
          expect(page).to have_content season_winter_bug.name
          expect(page).not_to have_content other_bug.name
        end
      end

      context '攻略度を「高い」に指定して検索する' do
        let!(:capture_8_chart) { create(:radar_chart, capture: 8) }
        let!(:other_chart) { create(:radar_chart) }

        it '攻略度の値が8・9・10のどれかを持つレコードのみ表示される' do
          choose 'search_capture_high'
          click_on '検索する'
          expect(page).to have_content capture_8_chart.bug.name
          expect(page).not_to have_content other_chart.bug.name
        end
      end

      context '繁殖力を「高い」に指定して検索する' do
        let!(:breeding_9_chart) { create(:radar_chart, breeding: 9) }
        let!(:other_chart) { create(:radar_chart) }

        it '繁殖力の値が8・9・10のどれかを持つレコードのみ表示される' do
          choose 'search_breeding_high'
          click_on '検索する'
          expect(page).to have_content breeding_9_chart.bug.name
          expect(page).not_to have_content other_chart.bug.name
        end
      end

      context '予防難度を「普通」に指定して検索する' do
        let!(:prevention_difficulty_6_chart) { create(:radar_chart, prevention_difficulty: 6) }
        let!(:other_chart) { create(:radar_chart) }

        it '予防難度の値が4・5・6・7のどれかを持つレコードのみ表示される' do
          choose 'search_prevention_difficulty_normal'
          click_on '検索する'
          expect(page).to have_content prevention_difficulty_6_chart.bug.name
          expect(page).to have_content other_chart.bug.name
        end
      end

      context '害を「低い」に指定して検索する' do
        let!(:injury_1_chart) { create(:radar_chart, injury: 1) }
        let!(:other_chart) { create(:radar_chart) }

        it '害の値が1・2・3のどれかを持つレコードのみ表示される' do
          choose 'search_injury_low'
          click_on '検索する'
          expect(page).to have_content injury_1_chart.bug.name
          expect(page).not_to have_content other_chart.bug.name
        end
      end

      context '不快感を「低い」に指定して検索する' do
        let!(:discomfort_3_chart) { create(:radar_chart, discomfort: 3) }
        let!(:other_chart) { create(:radar_chart) }

        it '不快感の値が1・2・3のどれかを持つレコードのみ表示される' do
          choose 'search_discomfort_low'
          click_on '検索する'
          expect(page).to have_content discomfort_3_chart.bug.name
          expect(page).not_to have_content other_chart.bug.name
        end
      end
    end
  end
end
