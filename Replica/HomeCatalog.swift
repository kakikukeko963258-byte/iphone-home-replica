import SwiftUI

struct HomeApp: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let upperColor: Color
    let lowerColor: Color
    let subtitle: String

    init(_ id: String, _ name: String, _ symbol: String, _ upper: UInt, _ lower: UInt, _ subtitle: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.upperColor = Color(rgb: upper)
        self.lowerColor = Color(rgb: lower)
        self.subtitle = subtitle
    }
}

enum HomeCatalog {
    static let pages: [[HomeApp]] = [firstPage, secondPage]

    static let firstPage: [HomeApp] = [
        .init("facetime", "FaceTime", "video.fill", 0x71DC73, 0x20B94D, "ビデオ通話と音声通話"),
        .init("calendar", "カレンダー", "calendar", 0xFFFFFF, 0xF5F5F7, "今日の予定を確認"),
        .init("photos", "写真", "photo.on.rectangle.angled", 0xFBE86B, 0xF08B58, "写真とビデオ"),
        .init("camera", "カメラ", "camera.fill", 0x757B85, 0x252A32, "写真を撮影"),
        .init("mail", "メール", "envelope.fill", 0x72CEFF, 0x0877E7, "メールを確認"),
        .init("maps", "マップ", "map.fill", 0xB6E899, 0x3A9C86, "場所と経路を検索"),
        .init("clock", "時計", "clock.fill", 0xFDFDFD, 0xE4E7EB, "時刻とアラーム"),
        .init("weather", "天気", "cloud.sun.fill", 0x70CEFF, 0x3487F2, "現在の天気"),
        .init("reminders", "リマインダー", "checklist", 0xFFFFFF, 0xF4F5F8, "やることを整理"),
        .init("notes", "メモ", "note.text", 0xFFF071, 0xE9AC20, "アイデアを書き留める"),
        .init("stocks", "株価", "chart.xyaxis.line", 0x29313D, 0x10151D, "市場の動きを見る"),
        .init("tv", "Apple TV", "tv.fill", 0x383A40, 0x111216, "番組と映画"),
        .init("books", "ブック", "book.fill", 0xFFB6D5, 0xD92F78, "本とオーディオブック"),
        .init("podcasts", "ポッドキャスト", "mic.fill", 0xE7C8FF, 0x9B36D7, "番組を聴く"),
        .init("health", "ヘルスケア", "heart.fill", 0xFFB8C2, 0xF34961, "健康データ"),
        .init("wallet", "ウォレット", "wallet.pass.fill", 0xFAFAFC, 0xD6DAE1, "カードとチケット"),
        .init("settings", "設定", "gearshape.fill", 0xC8CDD5, 0x68707B, "iPhoneの設定"),
        .init("translate", "翻訳", "character.bubble.fill", 0x79C7FF, 0x1676E8, "テキストを翻訳"),
        .init("compass", "コンパス", "safari.fill", 0xFAFAFC, 0xBBC6D4, "方角を確認"),
        .init("files", "ファイル", "folder.fill", 0x9CD8FF, 0x318DEB, "書類とフォルダ"),
        .init("tips", "ヒント", "lightbulb.fill", 0xFFF38A, 0xF1B928, "iPhoneの使い方"),
        .init("findmy", "探す", "location.fill", 0x84EDB1, 0x10A66C, "デバイスと人を探す"),
        .init("shortcuts", "ショートカット", "square.stack.3d.up.fill", 0xE5A8FF, 0x7A38E6, "操作を自動化"),
        .init("voice", "ボイスメモ", "waveform", 0xFFB0B0, 0xE3424A, "音声を録音")
    ]

    static let secondPage: [HomeApp] = [
        .init("appstore", "App Store", "A.square.fill", 0x8ED8FF, 0x1479E8, "アプリを見つける"),
        .init("media", "メディア", "play.rectangle.fill", 0xFFCADB, 0xF33167, "映像と音声"),
        .init("news", "News", "newspaper.fill", 0xFFFFFF, 0xD7DCE5, "ニュースを読む"),
        .init("home", "ホーム", "house.fill", 0x7CE3EA, 0x249BC5, "家電をコントロール"),
        .init("fitness", "フィットネス", "figure.run", 0xFFB1C0, 0xEE315D, "アクティビティ"),
        .init("freeform", "フリーボード", "scribble.variable", 0xD4C1FF, 0x7C5BE8, "アイデアを描く"),
        .init("calculator", "計算機", "plus.forwardslash.minus", 0xC5C9D0, 0x6B717B, "計算する"),
        .init("measure", "計測", "ruler", 0x42C7C2, 0x147C83, "長さを測る"),
        .init("contacts", "連絡先", "person.crop.circle.fill", 0x8CC7FF, 0x3875E8, "連絡先を表示"),
        .init("magnifier", "拡大鏡", "magnifyingglass", 0xD9EDF8, 0x4A7F9D, "細部を拡大"),
        .init("journal", "ジャーナル", "book.closed.fill", 0xF5D8B3, 0xC87942, "日々を記録"),
        .init("passwords", "パスワード", "key.fill", 0x9AD7FF, 0x2582D6, "パスワードを管理"),
        .init("games", "ゲーム", "gamecontroller.fill", 0xA8E99A, 0x3DA64B, "ゲームを楽しむ"),
        .init("store", "ストア", "bag.fill", 0xE9BA91, 0xA85630, "買い物をする"),
        .init("podcaststudio", "クリエイター", "sparkles", 0xE5C7FF, 0x9344DA, "作品を作る"),
        .init("translator", "辞書", "text.book.closed.fill", 0xB5D5FF, 0x5576D8, "言葉を調べる"),
        .init("calculator2", "単位換算", "arrow.left.arrow.right", 0x92D7CE, 0x328F87, "単位を変換"),
        .init("scanner", "書類スキャン", "doc.viewfinder", 0xD4E9FF, 0x527EC1, "書類を読み取る"),
        .init("measurelevel", "水準器", "level.fill", 0xA1DFBC, 0x31845B, "水平を測る"),
        .init("watch", "Watch", "applewatch", 0xD7DAE0, 0x5D636E, "Apple Watchを管理"),
        .init("homework", "学習", "graduationcap.fill", 0xB6C8FF, 0x565ED0, "学びを続ける"),
        .init("travel", "旅行", "airplane", 0xA7DFFF, 0x398CCB, "旅の情報"),
        .init("utilities", "便利ツール", "square.grid.2x2.fill", 0xE8EAF0, 0x828B9B, "よく使うツール"),
        .init("archive", "アーカイブ", "archivebox.fill", 0xD9C5AA, 0x87684B, "保存した項目")
    ]

    static let dock: [HomeApp] = [
        .init("phone", "電話", "phone.fill", 0x70DB76, 0x1AAA4D, "電話をかける"),
        .init("messages", "メッセージ", "message.fill", 0x80E785, 0x1FB64F, "メッセージを送る"),
        .init("safari", "Safari", "safari.fill", 0x8DD8FF, 0x2679E8, "Webを閲覧"),
        .init("dockmusic", "ミュージック", "music.note", 0xFFB7D0, 0xE92861, "音楽を再生")
    ]
}

extension Color {
    init(rgb: UInt) {
        self.init(.sRGB, red: Double((rgb >> 16) & 0xFF) / 255,
                  green: Double((rgb >> 8) & 0xFF) / 255,
                  blue: Double(rgb & 0xFF) / 255, opacity: 1)
    }
}
