struct TintApiConfig {
    // 💡 YOUR_PROJECT_ID를 실제 Supabase 프로젝트 ID로 변경하세요.
    static let projectURL = "https://iasqhsyevlafjvijsuwh.supabase.co"
    
    // 💡 YOUR_ANON_KEY를 실제 Supabase Anon Key로 변경하세요.
    static let apiKey = "eeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlhc3Foc3lldmxhZmp2aWpzdXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1NDcwNzUsImV4cCI6MjA3NzEyMzA3NX0.lqxvztIWgibzifgrU2eOBTVatpwF6Kc-MUAbhLQjMrE"
    
    // 테이블 이름은 'cosmetics'이며, 서버 URL은 'fetch'와 'save'에서 사용됩니다.
    static let tableName = "cosmetics"
    
    // REST API 서버 URL: 'fetchTints'와 'saveTint'에서 사용
    static let serverURL = "\(projectURL)/rest/v1/\(tableName)?apikey=\(apiKey)"
}
