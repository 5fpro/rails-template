Feature: 基本驗證
  Scenario: 沒登入
    When 前往 /admin
      Then 頁面轉跳
    When 前往 /sidekiq
      Then 頁面轉跳
  Scenario: 非 admin 登入
    Given user 登入
      When 前往 /admin
        Then 頁面轉跳
      When 前往 /sidekiq
        Then 頁面回應 404
  Scenario: admin 登入
    Given 管理者 登入
      When 前往 /admin
        Then 頁面回應 正常
      When 前往 /sidekiq
        Then 頁面回應 正常
  Scenario: admin 且啟動二階段認證 登入
    Given 二階段認證者 登入
      When 前往 /admin
        Then 頁面轉跳至 /admin/user_mfa_sessions/new
    Given 二階段認證者 登入
      And 通過MFA驗證
        When 前往 /admin
        Then 頁面回應 正常
