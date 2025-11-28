import SwiftUI

struct TintDetailView: View {
    let tint: Tint // Song 대신 Tint 모델 사용

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    // song.singer 대신 tint.brand 사용
                    Text(tint.brand)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Spacer()
                    // rating 표시
                    Text("\(String(tint.rating)) / 10점")
                        .font(.title)
                        .foregroundColor(.pink) // 틴트에 맞게 색상 변경
                }
                
                // MARK: - ⚠️ 수정된 부분: if let 내부의 Text에 패딩 적용
                if let colorFamily = tint.colorFamily {
                    Text("계열: \(colorFamily)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 10) // <-- 여기로 이동
                }
                // .padding(.bottom, 10) <-- 이 위치에 있으면 오류 발생
                
                // song.lyrics 대신 tint.description 사용
                Text(tint.description ?? "(설명 없음)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            .padding() // VStack 전체에 패딩 적용
        }
        // song.title 대신 tint.productName 사용
        .navigationTitle(tint.productName)
        .navigationBarTitleDisplayMode(.large)
    }
}
