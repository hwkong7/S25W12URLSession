import Foundation

// MARK: - Tint Structure Definition

/**
 틴트 화장품 정보를 담는 구조체입니다.
 Supabase의 'cosmetics' 테이블 스키마에 대응합니다.
 */
struct Tint: Identifiable, Decodable, Encodable, Hashable {
    // Identifiable 프로토콜을 위한 고유 ID (UUID 타입)
    let id: UUID
    
    // 제품명 (SQL의 'product_name'에 대응)
    let productName: String
    
    // 브랜드 (SQL의 'brand'에 대응)
    let brand: String
    
    // 색상 계열 (SQL의 'color_family'에 대응, 옵셔널로 처리 가능)
    let colorFamily: String?
    
    // 평점 (SQL의 'rating'에 대응)
    let rating: Int
    
    // 제품에 대한 설명 (SQL의 'description'에 대응, 옵셔널로 처리)
    let description: String?
    
    // 💡 참고: 만약 이미지 URL을 추가했다면 아래와 같이 추가할 수 있습니다.
    // let imageUrl: String?
    
    // MARK: - CodingKeys (Snake Case to Camel Case 매핑)
    
    // Swift의 Camel Case 변수 이름을 Supabase/PostgreSQL의
    // Snake Case 칼럼 이름에 맞게 매핑합니다.
    private enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case brand
        case colorFamily = "color_family"
        case rating
        case description
        // case imageUrl = "image_url" // 이미지 URL 추가 시 사용
    }
}
