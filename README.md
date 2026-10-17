# iPhone Home Replica

iPhoneのホーム画面を参考に、4列×6行、番号付きアイコン32個、Dock風の下部ガラス領域、検索欄、壁紙をSwiftUIで再現するiOSアプリです。24項目ずつの2ページを左右スワイプで切り替えます。アイコンの押下、編集時の揺れ、フォルダの作成・展開、ページ移動には動きを付けています。iOS 16以降に対応します。

Bundle IDはStudyQuizと同じ `com.studyquiz.dailyquiz` です。同時にはインストールできず、既存StudyQuizを置き換えます。iOSの実際のホーム画面を置き換える機能ではありません。

## IPAの作成

GitHubへpushするとmacOS runner + Xcodeで未署名IPAをビルドし、Actions Artifact `iphone-home-replica-ipa` とGitHub Releaseへ保存します。WindowsではXcode不要です。

IPAは設定済みの改造版AltForge Remoteで再署名してインストールしてください。READMEと操作手順はAltForge Remote Preview側を参照してください。

## レイアウトと動き

ホーム画面の位置・サイズ・ラベル・行間を画面幅に合わせます。ステータスバーはiOS標準表示です。番号アイコンをタップするとアイコンからページへ広がる起動風の変形が走り、戻る操作で閉じます。Reduce Motion設定にも対応します。

本プロジェクトはmainの最新ソースコミット `8e021a7a2612fe23ff33a42ce38a6d228151b17e` を元に、ホーム再現アプリとして独立させました。
