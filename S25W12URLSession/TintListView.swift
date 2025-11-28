import SwiftUI

struct TintListView: View {
    let viewModel: TintViewModel // TintViewModel 사용
    
    func deleteTint(offsets: IndexSet) { // 함수 이름 변경
        Task {
            for index in offsets {
                let tint = viewModel.tints[index]
                await viewModel.deleteTint(tint) // deleteTint() 호출
            }
        }
    }
    
    var body: some View {
        List {
            // viewModel.songs 대신 viewModel.tints 사용
            ForEach(viewModel.tints) { tint in
                NavigationLink(value: tint) {
                    HStack {
                        VStack(alignment: .leading) {
                            // song.title 대신 tint.productName 사용
                            Text(tint.productName)
                                .font(.headline)
                            // song.singer 대신 tint.brand 사용
                            Text(tint.brand)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        // 색상 계열 (colorFamily)도 추가할 수 있습니다.
                        if let colorFamily = tint.colorFamily {
                            Spacer()
                            Text(colorFamily)
                                .font(.caption)
                                .padding(4)
                                .background(Color.pink.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
            }
            .onDelete(perform: deleteTint) // deleteSong 대신 deleteTint 호출
        }
    }
}
