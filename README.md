## tundaa
このtundaa(ツンダー)というサービスは、「どう質問したら良いか分からない」という問題を解決する
エンジニア向けの、質問コンテンツ生成ツールです。

ユーザーは、質問のテンプレート使って、「上手い質問」を生成する事ができ、自前で質問を考えたり、web上の質問テンプレートを参考にする事とは違って、項目を埋めるだけで相手方に伝わる文章が生成される機能が備わっている事が特徴です。

## 開発
```bash
$ docker-compose up -d
$ docker-compose exec web bash
$ rails db:create
$ rails s -b 0.0.0.0
```

## テスト
```bash
$ docker-compose exec web bin/rspec
```

### GUIでのシステムテスト
```bash
$ open vnc://localhost:5901# パスワード「secret」
$ docker-compose exec web bin/rspec spec/system
```

## 環境
Ruby: 3.0.0

Ruby on Rails: 6.1.3

PostgreSQL: 11.11

