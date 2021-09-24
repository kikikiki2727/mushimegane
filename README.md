# :mag::bug: むしめがね :bug::mag_right:
家の中にときどき出てくる不快な虫を検索するサービスです。

<br />

[![Image from Gyazo](https://i.gyazo.com/2c85b4c127e9ba9f1b89c05314311acd.jpg)](https://gyazo.com/2c85b4c127e9ba9f1b89c05314311acd)

# :earth_americas: 運用実績 (2021年9月23日現在) 
サービスURL:https://mushimegane.fun/  

✅リリース日:2021年8月17日  
✅ページビュー:2,115PV  
✅ユニークユーザー数:413人

<br />

# :green_book: Qiita記事
[【個人開発】家の中にときどき出る不快な虫を検索するサービス「むしめがね」をリリースしました。](https://qiita.com/kimorisan/items/84997591c7c2c897da18)

✅62LGTM (2021年9月11日現在) 

<br />

# :mag: むしめがねについて
#### 【サービス概要】
家にときどき出てくる不快な虫を特徴や画像から検索し、対処法や予防法、実害を閲覧できます。

#### 【ユーザーが抱える課題】
- 家に発生した不快な虫が何という虫なのか、なぜ発生するのか、どうすれば適切な対処ができるのか知りたい。
- 家に出た不快な虫の駆除方法、予防方法、実害をまとめて知りたい。
- 家の中にどんな虫が発生するのか知りたい。
- 他の方はどうような対処をしているか知りたい。

#### 【解決方法】
家に発生した不快な虫の特徴や画像を元に検索し、その虫の対処法や今後に向けた予防法、同じ境遇の方の口コミ等を閲覧することによって、虫の適切な対処法や実害を簡単に得ることができる。

#### 【背景】
自宅にタカラダニという害虫が発生した際に、その駆除方法、今後に向けた予防方法、人間への実害などをまとめて知りたかった。  
また、家の中には他にどんな虫が発生したりするのか、どういった生活環境にすべきなのかをまとめて知りたかった。

<br />

# :wrench: 使用技術
- Rails 6.0.3.7
- Ruby 2.7.2
- Rspec(テスト)
- Rubocop（リントチェック）
- bullet（N+1問題検知）
- jQuery
- Bootstrap
- Nginx
- Puma
- AWS
  - VPC
  - EC2
    - Amazon Linux 2 
  - Route53
  - RDS
    - MySQL 
  - ALB
  - ACM
  - IAM
  - S3
  - Rekognition
  - Translate
- CircleCI
- Capistrano

<br />

# :construction: インフラ構成図
[![Image from Gyazo](https://i.gyazo.com/c6f5c2113c264ed5704732bd87863e59.png)](https://gyazo.com/c6f5c2113c264ed5704732bd87863e59)

<br />

# :memo: ER図
[![Image from Gyazo](https://i.gyazo.com/9e73078ddad7580998c662bd7923b317.png)](https://gyazo.com/9e73078ddad7580998c662bd7923b317)
