RSpec.configure do |config|
  config.before(:each, type: :system) do
    # driven_by(:rack_test)  # ステータスコードの確認
    # driven_by(:selenium_chrome)  # ブラウザ表示
    driven_by(:selenium_chrome_headless)  # ブラウザ非表示
  end
end
