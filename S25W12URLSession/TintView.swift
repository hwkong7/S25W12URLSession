import SwiftUI

struct TintView: View {
    // SongViewModel 대신 TintViewModel 사용
    @State private var viewModel = TintViewModel()
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            // SongListView 대신 TintListView 사용
            TintListView(viewModel: viewModel)
                // Song.self 대신 Tint.self 사용
                .navigationDestination(for: Tint.self) { tint in
                    TintDetailView(tint: tint)
                }
                .navigationTitle("틴트 목록")
                .task {
                    // loadSongs() 대신 loadTints() 호출
                    await viewModel.loadTints()
                }
                .refreshable {
                    await viewModel.loadTints()
                }
                .toolbar {
                    Button {
                        showingAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                .sheet(isPresented: $showingAddSheet) {
                    // SongAddView 대신 TintAddView 사용
                    TintAddView(viewModel: viewModel)
                }
        }
    }
}
