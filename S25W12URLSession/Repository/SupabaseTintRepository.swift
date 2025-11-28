import Foundation

// MARK: - SupabaseTintRepository Class

/**
 TintRepository 프로토콜을 구현하는 클래스로,
 Supabase를 통해 틴트 데이터를 관리합니다.
 */
final class SupabaseTintRepository: TintRepository {
    
    // MARK: - 1. Fetch Tints (데이터 가져오기)
    
    func fetchTints() async throws -> [Tint] {
        // 1. API 요청 URL 구성 (URL 생성 실패 시 오류 처리)
        guard let requestURL = URL(string: TintApiConfig.serverURL) else {
            throw URLError(.badURL)
        }
        
        do {
            // 2. 데이터 요청
            let (data, _) = try await URLSession.shared.data(from: requestURL)
            
            // 3. JSON 디코딩
            let decoder = JSONDecoder()
            return try decoder.decode([Tint].self, from: data)
        } catch {
            // 네트워크 오류, 디코딩 오류 등을 처리
            debugPrint("🚨 [FetchTints Error]: \(error.localizedDescription)")
            throw error // 뷰모델로 오류를 전달
        }
    }
    
    // MARK: - 2. Save Tint (데이터 저장/업데이트)
    
    func saveTint(_ tint: Tint) async throws {
        // 1. API 요청 URL 구성 (URL 생성 실패 시 오류 처리)
        guard let requestURL = URL(string: TintApiConfig.serverURL) else {
            throw URLError(.badURL)
        }
        
        // 2. URLRequest 설정
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. HTTP Body 설정
        request.httpBody = try JSONEncoder().encode(tint)
        
        do {
            // 4. 요청 실행
            let (_, response) = try await URLSession.shared.data(for: request)

            // 5. 응답 확인 (Supabase에서 성공 시 201 Created)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 201
            else {
                throw URLError(.badServerResponse)
            }
        } catch {
            debugPrint("🚨 [SaveTint Error]: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - 3. Delete Tint (데이터 삭제)
    
    func deleteTint(_ id: String) async throws {
        // 1. API 요청 URL 구성 (URL 생성 실패 시 오류 처리)
        let urlString = "\(TintApiConfig.projectURL)/rest/v1/cosmetics?id=eq.\(id)&apikey=\(TintApiConfig.apiKey)"
        
        guard let requestURL = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // 2. URLRequest 설정
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        do {
            // 3. 요청 실행
            let (_, response) = try await URLSession.shared.data(for: request)

            // 4. 응답 확인 (Supabase에서 성공 시 204 No Content)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 204
            else {
                throw URLError(.badServerResponse)
            }
        } catch {
            debugPrint("🚨 [DeleteTint Error]: \(error.localizedDescription)")
            throw error
        }
    }
}
