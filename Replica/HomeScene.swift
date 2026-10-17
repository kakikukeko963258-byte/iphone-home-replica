import SwiftUI

struct HomeScene: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Namespace private var iconFlight
    @State private var selectedPage = 0
    @State private var selectedApp: HomeApp?
    @State private var editing = false
    @State private var searchPresented = false
    private let horizontalInset: CGFloat = 13

    var body: some View {
        GeometryReader { geometry in
            let iconSize = min(66, geometry.size.width * 0.16)
            let rowHeight = iconSize + 22
            let spacing = max(7, min(20, (geometry.size.height - rowHeight * 6 - 170) / 5))
            let gridHeight = rowHeight * 6 + spacing * 5

            ZStack {
                AuroraBackdrop()

                VStack(spacing: 0) {
                    TabView(selection: $selectedPage) {
                        ForEach(HomeCatalog.pages.indices, id: \.self) { page in
                            HomeIconGrid(apps: HomeCatalog.pages[page], iconSize: iconSize,
                                         rowSpacing: spacing, editing: $editing,
                                         selectedAppID: selectedApp?.id, namespace: iconFlight,
                                         open: showApp)
                                .tag(page)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: gridHeight)

                    PageDots(selectedPage: selectedPage)
                        .padding(.top, 7)
                        .frame(height: 19)

                    SearchCapsule { searchPresented = true }
                        .frame(height: 36)
                        .padding(.top, 4)

                    DockShelf(iconSize: iconSize, selectedAppID: selectedApp?.id,
                              namespace: iconFlight, open: showApp)
                        .frame(height: iconSize + 24)
                        .padding(.top, 10)
                }
                .padding(.horizontal, horizontalInset)
                .padding(.top, 7)
                .padding(.bottom, 5)

                if let app = selectedApp {
                    AppLaunchScene(app: app, namespace: iconFlight,
                                   dismiss: closeApp)
                        .transition(.opacity)
                        .zIndex(10)
                }

                if editing && selectedApp == nil {
                    VStack {
                        HStack {
                            Spacer()
                            Button("完了") { withAnimation(.easeOut(duration: 0.18)) { editing = false } }
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.horizontal, 16).padding(.vertical, 9)
                                .background(.ultraThinMaterial, in: Capsule())
                                .overlay(Capsule().stroke(.white.opacity(0.2), lineWidth: 0.7))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    .zIndex(5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .sheet(isPresented: $searchPresented) { AppSearchSheet() }
        .animation(reduceMotion ? .easeOut(duration: 0.14) : .spring(response: 0.42, dampingFraction: 0.88), value: selectedApp?.id)
        .statusBarHidden(false)
    }

    private func showApp(_ app: HomeApp) {
        guard !editing else {
            withAnimation(.easeOut(duration: 0.18)) { editing = false }
            return
        }
        withAnimation(reduceMotion ? .easeOut(duration: 0.14) : .spring(response: 0.48, dampingFraction: 0.86)) {
            selectedApp = app
        }
    }

    private func closeApp() {
        withAnimation(reduceMotion ? .easeOut(duration: 0.14) : .spring(response: 0.44, dampingFraction: 0.9)) {
            selectedApp = nil
        }
    }
}

private struct HomeIconGrid: View {
    let apps: [HomeApp]
    let iconSize: CGFloat
    let rowSpacing: CGFloat
    @Binding var editing: Bool
    let selectedAppID: String?
    let namespace: Namespace.ID
    let open: (HomeApp) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 3), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: rowSpacing) {
            ForEach(apps) { app in
                HomeIconTile(app: app, size: iconSize, editing: $editing,
                             selectedAppID: selectedAppID, namespace: namespace,
                             open: { open(app) })
                    .frame(height: iconSize + 22)
            }
        }
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            if editing { withAnimation(.easeOut(duration: 0.18)) { editing = false } }
        }
    }
}

private struct HomeIconTile: View {
    let app: HomeApp
    let size: CGFloat
    @Binding var editing: Bool
    let selectedAppID: String?
    let namespace: Namespace.ID
    let open: () -> Void

    var body: some View {
        Button(action: open) {
            VStack(spacing: 4) {
                AppIconArtwork(app: app, size: size)
                    .matchedGeometryEffect(id: app.id, in: namespace, isSource: selectedAppID != app.id)
                    .shadow(color: .black.opacity(0.22), radius: 3, y: 2)
                Text(app.name)
                    .font(.system(size: 11.5, weight: .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.55), radius: 2, y: 1)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .rotationEffect(.degrees(editing ? (Int(app.id.unicodeScalars.first?.value ?? 0) % 2 == 0 ? 1.65 : -1.65) : 0))
        .animation(editing ? .easeInOut(duration: 0.13).repeatForever(autoreverses: true) : .easeOut(duration: 0.12), value: editing)
        .onLongPressGesture(minimumDuration: 0.48) {
            withAnimation(.easeInOut(duration: 0.18)) { editing = true }
        }
        .accessibilityLabel(app.name)
    }
}

struct AppIconArtwork: View {
    let app: HomeApp
    let size: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.225, style: .continuous)
                .fill(LinearGradient(colors: [app.upperColor, app.lowerColor], startPoint: .topLeading, endPoint: .bottomTrailing))
            if app.id == "calendar" {
                VStack(spacing: 0) {
                    Text("MONDAY")
                        .font(.system(size: size * 0.115, weight: .bold, design: .rounded))
                        .tracking(0.7)
                        .foregroundStyle(Color(red: 0.88, green: 0.2, blue: 0.22))
                        .padding(.top, size * 0.19)
                    Text("17")
                        .font(.system(size: size * 0.55, weight: .light, design: .rounded))
                        .foregroundStyle(Color(white: 0.12))
                        .offset(y: -size * 0.035)
                }
            } else {
                Image(systemName: app.symbol.trimmingCharacters(in: .whitespaces))
                    .font(.system(size: size * 0.47, weight: .medium))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(app.id == "notes" || app.id == "tips" ? .black.opacity(0.72) : .white)
                    .shadow(color: .black.opacity(0.12), radius: 1, y: 1)
            }
            RoundedRectangle(cornerRadius: size * 0.225, style: .continuous)
                .fill(LinearGradient(colors: [.white.opacity(0.25), .white.opacity(0.02), .clear], startPoint: .topLeading, endPoint: .center))
                .allowsHitTesting(false)
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.225, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: size * 0.225, style: .continuous).stroke(.white.opacity(0.22), lineWidth: 0.65))
    }
}

private struct PageDots: View {
    let selectedPage: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<2, id: \.self) { index in
                Capsule().fill(index == selectedPage ? .white : .white.opacity(0.42))
                    .frame(width: index == selectedPage ? 15 : 6, height: 6)
                    .animation(.spring(response: 0.25, dampingFraction: 0.78), value: selectedPage)
            }
        }
        .accessibilityLabel("ページ \(selectedPage + 1)/2")
    }
}

private struct SearchCapsule: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 7) {
                Image(systemName: "magnifyingglass").font(.system(size: 13, weight: .semibold))
                Text("検索").font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(.white.opacity(0.92))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial, in: Capsule())
            .overlay(Capsule().stroke(.white.opacity(0.2), lineWidth: 0.7))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 46)
    }
}

private struct DockShelf: View {
    let iconSize: CGFloat
    let selectedAppID: String?
    let namespace: Namespace.ID
    let open: (HomeApp) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(HomeCatalog.dock) { app in
                Button { open(app) } label: {
                    AppIconArtwork(app: app, size: iconSize)
                        .matchedGeometryEffect(id: app.id, in: namespace, isSource: selectedAppID != app.id)
                        .shadow(color: .black.opacity(0.2), radius: 3, y: 2)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DockPressStyle())
                .accessibilityLabel(app.name)
            }
        }
        .padding(.horizontal, 13)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 29, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 29, style: .continuous).stroke(.white.opacity(0.22), lineWidth: 0.8))
        .shadow(color: .black.opacity(0.2), radius: 16, y: 7)
    }
}

private struct DockPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 0.88 : 1)
            .animation(.spring(response: 0.24, dampingFraction: 0.62), value: configuration.isPressed)
    }
}

private struct AuroraBackdrop: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(colors: [Color(rgb: 0x0B1731), Color(rgb: 0x17274D), Color(rgb: 0x071622)], startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle().fill(RadialGradient(colors: [Color(rgb: 0x42A8D4).opacity(0.72), Color(rgb: 0x22629F).opacity(0.24), .clear], center: .center, startRadius: 4, endRadius: geometry.size.width * 0.6))
                    .frame(width: geometry.size.width * 1.18, height: geometry.size.width * 1.18)
                    .position(x: geometry.size.width * 0.87, y: geometry.size.height * 0.26)
                    .blur(radius: 28)
                Ellipse().fill(RadialGradient(colors: [Color(rgb: 0x7157B7).opacity(0.5), Color(rgb: 0x304E86).opacity(0.16), .clear], center: .center, startRadius: 2, endRadius: geometry.size.width * 0.55))
                    .frame(width: geometry.size.width * 1.35, height: geometry.size.height * 0.52)
                    .rotationEffect(.degrees(-22))
                    .position(x: geometry.size.width * 0.08, y: geometry.size.height * 0.67)
                    .blur(radius: 32)
                LinearGradient(colors: [.black.opacity(0.08), .clear, .black.opacity(0.22)], startPoint: .top, endPoint: .bottom)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

private struct AppSearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""
    private var results: [HomeApp] {
        (HomeCatalog.pages.flatMap { $0 } + HomeCatalog.dock).filter { query.isEmpty || $0.name.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            List(results) { app in
                HStack(spacing: 12) {
                    AppIconArtwork(app: app, size: 38)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(app.name).font(.body)
                        Text(app.subtitle).font(.caption).foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 3)
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Color(rgb: 0x111827))
            .searchable(text: $query, prompt: "アプリを検索")
            .navigationTitle("検索")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { Button("完了") { dismiss() } } }
        }
        .preferredColorScheme(.dark)
    }
}
