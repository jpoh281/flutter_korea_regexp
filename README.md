# korea_regexp

https://github.com/bluewings/korean-regexp

해당 깃허브를 보고 자바스크립트로 구현된 한글 정규표현식 패키지를 다트로 변경한 플러그인입니다.

## 현재 구현된 기능
- [x] 한글 자동완성을 위한 정규식
- [ ] 영타 -> 한타
- [x] 한타 -> 영타
- [ ] 조사 자동 치환
- [X] 자소 분리
- [ ] 자소 합치기


## 기능 설명

### 한글 자동완성을 위한 정규식
- initial search : 초성으로 검색 여부
ex) ㄱㅇㄷ -> 강원도

- startsWith : 시작과 일치

- endsWith : 마지막과 일치

- ignoreSpace : 공백 무시

- ignoreCase : 대소문자 무시

- fuzzy


천천히 추가할 예정이지만, 완성되지 않은 기능이나 에러에 대한 pr은 언제나 환영입니다.
