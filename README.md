# iPhone Home Replica

iOSのホーム画面を題材にした、新規実装のSwiftUIアプリです。アプリ本体のソース、レイアウト、壁紙、アイコン描画はこのプロジェクト内に独立して用意しています。既存アプリの画面コードやアートワークは取り込んでいません。

4列×6行の2ページ、ページ切り替え、Dock、検索、アプリアイコンから広がる起動アニメーション、長押し編集時の揺れを実装しています。iOS標準のステータスバーを使います。iOS 16以降に対応します。

Bundle ID: `com.studyquiz.dailyquiz`。StudyQuizと同時にインストールできず、置き換えます。iOS本体のホーム画面を置き換える機能ではありません。

## 公開ビルド

`main`へのpushまたはActionsの手動実行で、GitHub ActionsのmacOS runner + Xcodeが未署名IPAを作成します。Actions Artifact `iphone-home-replica-ipa` とGitHub Releaseから取得できます。AltForge Remoteで再署名してインストールします。

## ソース構成

- `Replica/ReplicaApp.swift`: アプリ起動
- `Replica/HomeScene.swift`: 画面配置、ページ切り替え、アイコン、Dock、検索、起動画面
- `Replica/HomeCatalog.swift`: このアプリ専用のアイコン一覧と描画色
- `Replica/AppLaunchScene.swift`: アイコンから展開するアプリプレビュー
- `Replica/Assets.xcassets`: このプロジェクトで新規作成したアプリアイコン

XcodeGenで生成するiOSアプリです。外部Swift packageや別アプリのプロジェクト依存はありません。
