import Foundation

// MARK: - TintRepository Definition

/**
 틴트 화장품 데이터를 가져오고, 저장하고, 삭제하는
 데이터 접근 계층(Data Access Layer)의 역할을 정의하는 프로토콜입니다.
 
 - Note: 'Sendable' 프로토콜은 Swift Concurrency(동시성) 환경에서 안전하게
   객체를 공유할 수 있도록 합니다.
 */
protocol TintRepository: Sendable {
    
    /**
     데이터베이스에서 모든 틴트 목록을 비동기적으로 가져옵니다.
     
     - Returns: [Tint] 타입의 틴트 목록
     */
    func fetchTints() async throws -> [Tint]
    
    /**
     새로운 틴트 정보를 데이터베이스에 저장하거나 기존 틴트 정보를 업데이트합니다.
     
     - Parameter tint: 저장할 Tint 객체
     */
    func saveTint(_ tint: Tint) async throws
    
    /**
     특정 ID를 가진 틴트 정보를 데이터베이스에서 삭제합니다.
     
     - Parameter id: 삭제할 틴트의 고유 ID (UUID의 String 표현)
     */
    func deleteTint(_ id: String) async throws
}
