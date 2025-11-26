//import Foundation
//
//// MARK: - SupabaseTintRepository Class
//
///**
// TintRepository 프로토콜을 구현하는 클래스로,
// Supabase를 통해 틴트 데이터를 관리합니다.
// */
//final class SupabaseTintRepository: TintRepository {
//    
//    // SongApiConfig 대신 TintApiConfig라는 설정 구조체를 사용한다고 가정합니다.
//    // 이는 Supabase 프로젝트 URL, API Key, 그리고 테이블 이름을 담고 있어야 합니다.
//    // 💡 실제 사용 시 TintApiConfig를 정의해야 합니다.
//    
//    // MARK: - 1. Fetch Tints (데이터 가져오기)
//    
//    func fetchTints() async throws -> [Tint] {
//        // 1. API 요청 URL 구성 (테이블 이름: 'cosmetics' 사용)
//        //let requestURL = URL(string: TintApiConfig.serverURL)!
//        
//        // 2. 데이터 요청
//        let (data, _) = try await URLSession.shared.data(from: requestURL)
//        
//        // 3. JSON 디코딩 (Song 대신 Tint 모델 사용)
//        let decoder = JSONDecoder()
//        // try! 대신 try를 사용하여 오류 처리 (try!는 실제 앱에서 위험)
//        return try decoder.decode([Tint].self, from: data)
//    }
//    
//    // MARK: - 2. Save Tint (데이터 저장/업데이트)
//    
//    func saveTint(_ tint: Tint) async throws {
//        // 1. API 요청 URL 구성 (테이블 이름: 'cosmetics' 사용)
//        //let requestURL = URL(string: TintApiConfig.serverURL)!
//        
//        // 2. URLRequest 설정
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // 3. HTTP Body 설정 (Song 대신 Tint 모델 인코딩)
//        request.httpBody = try JSONEncoder().encode(tint)
//        
//        // 4. 요청 실행
//        let (_, response) = try await URLSession.shared.data(for: request)
//
//        // 5. 응답 확인 (Supabase에서 성공 시 201 Created)
//        guard let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 201
//        else {
//            throw URLError(.badServerResponse)
//        }
//    }
//    
//    // MARK: - 3. Delete Tint (데이터 삭제)
//    
//    func deleteTint(_ id: String) async throws {
//        // 1. API 요청 URL 구성 (테이블 이름: 'cosmetics'와 ID 쿼리 사용)
//        // TintApiConfig.projectURL은 프로젝트의 기본 URL
//        // TintApiConfig.apiKey는 프로젝트 API 키
//        // /rest/v1/cosmetics 테이블과 id 필터를 사용하도록 수정
//        let urlString = "\(TintApiConfig.projectURL)/rest/v1/cosmetics?id=eq.\(id)&apikey=\(TintApiConfig.apiKey)"
//        let requestURL = URL(string: urlString)!
//        
//        // 2. URLRequest 설정
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "DELETE"
//        
//        // 3. 요청 실행
//        let (_, response) = try await URLSession.shared.data(for: request)
//
//        // 4. 응답 확인 (Supabase에서 성공 시 204 No Content)
//        guard let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 204
//        else {
//            throw URLError(.badServerResponse)
//        }
//    }
//}
