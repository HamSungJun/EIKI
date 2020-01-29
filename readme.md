# [Spring-MVC] EIKI - ERICA Food WiKi

## 프로젝트 목적

- 우리학교 학생들에게 학교 앞 근처 상가에 존재하는 음식점들의 정보(가격, 배달 유무, 선호도) 제공
- 커뮤니티 기능 도입을 통한 음식 사진, 개개인의 후기 공유

## Tech Stack

| Frontend | Backend | Database | VCS |
|:--------:|:--------:|:-------:|:-------:|
| `HTML5` | `JAVA` | `MYSQL` | `GIT` |
| `CSS3` | `SPRING-MVC` |  |
| `JAVASCRIPT(ES6)` | `DOCKER`  | |

## Dev Images

| LOGIN | LOGIN2 |
|:--------:|:--------:|
|![EIKI_LOGIN](./devImages/login.png)|![EIKI_LOGIN2](./devImages/login2.png)|

<hr />

| JOIN | JOIN2 |
|:--------:|:--------:|
|![EIKI_JOIN](./devImages/join.png)|![EIKI_JOIN2](./devImages/join2.png)|

## Dev History

### 2020.01.29

- 개발 내용

    - 회원가입 혹은 로그인 성공시 세션이 발행된 상태로 `/eiki/home`으로 이동.
    
    - `SessionCheckInterceptor`통해 실제 서비스가 이루어지는 `/eiki` 하위 URL에 접근시 인터셉터는 지속적으로 세션 유효성 검사.
    
    - `/` 하위는 `login`, `join`, `find` 가 존재하는데 이는 세션과는 관련이 없으므로 지속적으로 세션 정보를 삭제.
    
- 개발 예정

    - 로그인 실패시 페이지 전환없이 에러 메시지를 출력해 주어야 하는데 `form` 태그 대신 `ajax` 콜로 대체.
    
    - `/eiki/home` 페이지 세션 유저 정보 반영하여 퍼블리싱