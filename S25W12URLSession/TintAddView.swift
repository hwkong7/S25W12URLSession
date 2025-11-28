import SwiftUI

struct TintAddView: View {
    let viewModel: TintViewModel // TintViewModel 사용
    
    @Environment(\.dismiss) var dismiss
    
    // Tint 모델에 맞게 State 변수 변경
    @State var productName = "" // title -> productName
    @State var brand = ""       // singer -> brand
    @State var colorFamily = "" // 새로 추가
    @State var rating = 5       // 1~10점 중 중간값으로 초기화
    @State var description = "" // lyrics -> description
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("제품 정보 *")) {
                    TextField("제품명", text: $productName)
                    TextField("브랜드", text: $brand)
                    TextField("색상 계열 (예: 핑크, 코랄)", text: $colorFamily) // 색상 계열 추가
                }
                
                Section(header: Text("선호도 *")) {
                    // 평점을 1~10점으로 변경
                    Picker("별점", selection: $rating) {
                        ForEach(1...10, id: \.self) { score in
                            Text("\(score)점")
                                .tag(score)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("제품 설명")) {
                    // TextEditor의 레이블 변경
                    TextEditor(text: $description)
                        .frame(height: 150)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        Task {
                            // Tint 객체를 생성하여 addTint 호출
                            await viewModel.addTint(
                                Tint(
                                    id: UUID(),
                                    productName: productName,
                                    brand: brand,
                                    colorFamily: colorFamily.isEmpty ? nil : colorFamily, // 빈 문자열이면 nil 처리
                                    rating: rating,
                                    description: description.isEmpty ? nil : description
                                )
                            )
                            dismiss()
                        }
                    }
                    // 필수 입력 필드 (제품명, 브랜드) 검사
                    .disabled(productName.isEmpty || brand.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
        }
    }
}
