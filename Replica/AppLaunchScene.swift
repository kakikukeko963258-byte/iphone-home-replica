import SwiftUI

struct AppLaunchScene: View {
    let app: HomeApp
    let namespace: Namespace.ID
    let dismiss: () -> Void
    @State private var contentVisible = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [app.lowerColor.opacity(0.96), Color(rgb: 0x0B1020), Color(rgb: 0x080B12)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            Circle().fill(app.upperColor.opacity(0.22)).frame(width: 330, height: 330).blur(radius: 100).offset(x: 170, y: -280)

            VStack(spacing: 0) {
                HStack {
                    Button(action: dismiss) {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 38, height: 38)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .accessibilityLabel("ホーム画面に戻る")
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                Spacer(minLength: 30)
                AppIconArtwork(app: app, size: 104)
                    .matchedGeometryEffect(id: app.id, in: namespace, isSource: true)
                    .shadow(color: app.upperColor.opacity(0.28), radius: 24, y: 8)
                Text(app.name)
                    .font(.system(size: 27, weight: .bold, design: .rounded))
                    .padding(.top, 16)
                Text(app.subtitle)
                    .font(.system(size: 15))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.top, 5)
                Spacer(minLength: 30)

                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 10) {
                        Image(systemName: app.symbol.trimmingCharacters(in: .whitespaces))
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(app.upperColor)
                        Text(app.name).font(.system(size: 17, weight: .semibold))
                        Spacer()
                        Image(systemName: "ellipsis").foregroundStyle(.white.opacity(0.65))
                    }
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(LinearGradient(colors: [app.upperColor.opacity(0.28), .white.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 155)
                        .overlay {
                            VStack(spacing: 9) {
                                Image(systemName: app.symbol.trimmingCharacters(in: .whitespaces))
                                    .font(.system(size: 38, weight: .light))
                                Text(app.subtitle).font(.system(size: 14, weight: .medium))
                                Text("アプリのプレビュー").font(.system(size: 12)).foregroundStyle(.white.opacity(0.58))
                            }
                            .foregroundStyle(.white.opacity(0.94))
                        }
                    HStack {
                        Label("今日", systemImage: "sun.max.fill").foregroundStyle(.yellow)
                        Spacer()
                        Text("ホーム画面プレビュー").foregroundStyle(.white.opacity(0.55))
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .padding(18)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 26, style: .continuous).stroke(.white.opacity(0.14), lineWidth: 0.8))
                .padding(.horizontal, 20)
                .opacity(contentVisible ? 1 : 0)
                .offset(y: contentVisible ? 0 : 24)

                Spacer(minLength: 28)
                Capsule().fill(.white.opacity(0.75)).frame(width: 135, height: 5).padding(.bottom, 6)
            }
        }
        .contentShape(Rectangle())
        .gesture(DragGesture(minimumDistance: 20).onEnded { value in
            if value.translation.height > 100 { dismiss() }
        })
        .onAppear {
            withAnimation(.easeOut(duration: 0.28).delay(0.12)) { contentVisible = true }
        }
        .accessibilityAddTraits(.isModal)
    }
}
