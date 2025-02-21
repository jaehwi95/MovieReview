#  프로그라피-MovieReview

프로그라피 10기 iOS 과제전형 

## 주요 기술 스택

- SwiftUI: 선언형 UI 구현
- TCA (The Composable Architecture): 단방향 상태 관리 및 기능 모듈화
- async/await (Swift Concurrency): 비동기 네트워크 요청 및 데이터 처리
- NukeUI: 네트워크 이미지 로딩 및 캐싱

## 프로젝트 폴더 구조

```plaintext
MovieReview
│── App/                     # 앱의 최상위 엔트리 포인트
│── Domain/                  # 핵심 도메인 로직 관리
│   └── Movie/               # 영화 관련 도메인 로직
│── Features/                # 각 기능(Feature)별 UI 및 비즈니스 로직
│   ├── Detail/              # 영화 상세 페이지
│   ├── Home/                # 홈 화면 (영화 목록)
│   ├── Main/                # 메인 화면 (탭뷰)
│   └── MyPage/              # 마이 리스트 화면
│── Network/                 # 네트워크 관련 코드
│── UI/                      # 공통 UI 컴포넌트
└── Util/                    # 유틸리티 기능 (날짜 포맷 변환 등)

## 화면 스크린샷

| Home Screen | My Screen | Detail Screen |
|------------|---------------|----------------|
| ![Home](Images/main.png) | ![My](images/mypage.png) | ![Detail](images/detail-saved.png) |
| ![Home](Images/main-list.png) | ![My](images/mypage-dropdown.png) | ![Detail](images/detail-menu.png) |
|  | ![My](images/mypage-filtered.png) | ![Detail](images/detail-edit.png) |

## Supported Platforms

- iOS 17.0
- Xcode 16.2

## License

MIT