#  Gitの運用ルール
## ブランチ運用
- GitHub flowを使用する
    - `master`: メインブランチ。常にビルドが通りリリースできる状態のものとする
    - `feature`: 各機能の開発用ブランチ。もし機能が大きい場合にはdevelopを作って、そこにいくつかのfeatureをマージしても良い。
- 例:
    - 1行目: `<Prefix>: <簡潔な説明>(<対応するIssue>)
    - 2行目: (空白)
    - 3行目: 説明の詳細や補足、チケット課題のリンクなどを書く

```
style: 変数・関数名のリネーム(#2)

適切な命名規則に従った名称にリネームを行った。
```

- Prefixは以下を使用する
    - 参考: [Angular.js/DEVELOPERS.md](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)


<img width="800" alt="image" src="https://i.imgur.com/qcjaXH2.png">
