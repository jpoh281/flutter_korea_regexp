# korea_regexp

https://github.com/bluewings/korean-regexp

해당 깃허브를 보고 자바스크립트로 구현된 한글 정규표현식 패키지를 다트로 변경한 플러그인입니다.

## 현재 구현된 기능
- [x] 한글 자동완성을 위한 정규식
- [ ] 영타 -> 한타
- [x] 한타 -> 영타
- [x] 조사 자동 치환
- [X] 자소 분리
- [ ] 자소 합치기


## 기능 설명

### 한글 자동완성을 위한 정규식
![KakaoTalk_Photo_2021-11-01-23-59-33](https://user-images.githubusercontent.com/54665433/139692643-126e799b-a38a-482c-ae41-8a1609e85e07.gif)
- initial search : 초성으로 검색 여부
ex) ㄱㅇㄷ -> 강원도

- startsWith : 시작과 일치

- endsWith : 마지막과 일치

- ignoreSpace : 공백 무시

- ignoreCase : 대소문자 무시

- fuzzy

### 한타 -> 영타
![KakaoTalk_Photo_2021-11-01-23-58-35](https://user-images.githubusercontent.com/54665433/139692493-245f66f1-5b30-4152-af0b-2f25d3d85c6f.gif)

### 자소 분리
![KakaoTalk_Photo_2021-11-01-23-56-29](https://user-images.githubusercontent.com/54665433/139692340-ff124f09-bd2f-4ca4-ac8b-df1f39fb27d4.gif)

### 자소 자동 치환
![KakaoTalk_Photo_2022-03-11-00-13-48](https://user-images.githubusercontent.com/54665433/157692127-39c438cb-6241-4c0f-962a-e5bf1517663a.gif)



천천히 추가할 예정이지만, 완성되지 않은 기능이나 에러에 대한 pr은 언제나 환영입니다.

