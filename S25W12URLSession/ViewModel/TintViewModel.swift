import SwiftUI

/**
 틴트(Tint) 데이터를 관리하고 뷰에 데이터를 제공하는 ViewModel입니다.
 SwiftUI의 @Observable 매크로를 사용하여 뷰 업데이트를 처리합니다.
 */
@MainActor
@Observable
final class TintViewModel {
    
    // MARK: - Properties
    
    // 틴트 데이터 접근을 위한 Repository 인스턴스
    private let repository: TintRepository
    
    // 틴트 목록을 저장하는 내부 배열. @Observable에 의해 변화가 감지됩니다.
    private var _tints: [Tint] = []
    
    // 외부에서 접근 가능한 틴트 목록 (읽기 전용)
    var tints: [Tint] { _tints }
    
    // SwiftUI Navigation을 관리하는 경로 (필요 시 사용)
    var path = NavigationPath()
    
    // MARK: - Initialization
    
    // TintRepository의 구현체(SupabaseTintRepository)를 기본값으로 사용합니다.
    init(repository: TintRepository = SupabaseTintRepository()) {
        self.repository = repository
    }

    // MARK: - Data Operations (CRUD)
    
    /**
     데이터베이스에서 모든 틴트 목록을 비동기적으로 로드합니다.
     */
    func loadTints() async {
        do {
            // repository.fetchTints()를 호출하고 결과를 _tints에 저장
            _tints = try await repository.fetchTints()
        } catch {
            // 오류 처리: 실제 앱에서는 사용자에게 알림을 보여주는 등의 처리가 필요합니다.
            debugPrint("틴트 목록 로드 중 에러 발생: \(error)")
        }
    }
    
    /**
     새로운 틴트 정보를 데이터베이스에 저장하고, 성공 시 목록에 추가합니다.
     
     - Parameter tint: 추가/저장할 Tint 객체
     */
    func addTint(_ tint: Tint) async {
        do {
            try await repository.saveTint(tint)
            // 성공적으로 저장되면 로컬 목록에 추가 (뷰 자동 업데이트)
            _tints.append(tint)
        }
        catch {
            debugPrint("틴트 추가/저장 중 에러 발생: \(error)")
        }
    }
    
    /**
     특정 틴트 정보를 데이터베이스에서 삭제하고, 성공 시 목록에서 제거합니다.
     
     - Parameter tint: 삭제할 Tint 객체
     */
    func deleteTint(_ tint: Tint) async {
        do {
            // UUID를 String으로 변환하여 Repository에 전달
            try await repository.deleteTint(tint.id.uuidString)
            
            // 성공적으로 삭제되면 로컬 목록에서 제거 (뷰 자동 업데이트)
            if let index = _tints.firstIndex(where: { $0.id == tint.id }) {
                _tints.remove(at: index)
            }
        }
        catch {
            debugPrint("틴트 삭제 중 에러 발생: \(error)")
        }
    }
}
