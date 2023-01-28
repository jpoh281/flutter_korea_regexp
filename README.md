# korea_regexp
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

https://github.com/bluewings/korean-regexp

해당 깃허브를 보고 자바스크립트로 구현된 한글 정규표현식 패키지를 다트로 변경한 플러그인입니다.

## 현재 구현된 기능
- [x] 한글 자동완성을 위한 정규식
- [x] 영타 -> 한타
- [x] 한타 -> 영타
- [x] 조사 자동 치환
- [x] 자소 분리
- [x] 자소 합치기


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

### 영타 -> 한타
![KakaoTalk_Photo_2022-03-21-23-08-40](https://user-images.githubusercontent.com/54665433/159278819-dc296220-d218-482d-a6ed-3ffb2f99c30c.gif)

### 자소 분리
![KakaoTalk_Photo_2021-11-01-23-56-29](https://user-images.githubusercontent.com/54665433/139692340-ff124f09-bd2f-4ca4-ac8b-df1f39fb27d4.gif)

### 자소 합치기
![KakaoTalk_Photo_2022-03-21-22-22-02](https://user-images.githubusercontent.com/54665433/159269633-041e3457-3fc3-4920-9945-348286eb3162.gif)

### 조사 자동 치환
![KakaoTalk_Photo_2022-03-11-00-13-48](https://user-images.githubusercontent.com/54665433/157692127-39c438cb-6241-4c0f-962a-e5bf1517663a.gif)


## Contributors ✨
### Issue, PR 언제나 환영입니다.
Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://honor-driven.dev/"><img src="https://avatars.githubusercontent.com/u/54665433?v=4?s=100" width="100px;" alt="홍종표"/><br /><sub><b>홍종표</b></sub></a><br /><a href="https://github.com/jpoh281/flutter_korea_regexp/commits?author=jpoh281" title="Code">💻</a> <a href="https://github.com/jpoh281/flutter_korea_regexp/commits?author=jpoh281" title="Documentation">📖</a> <a href="https://github.com/jpoh281/flutter_korea_regexp/commits?author=jpoh281" title="Tests">⚠️</a> <a href="#ideas-jpoh281" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-jpoh281" title="Maintenance">🚧</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://velog.io/@viiviii"><img src="https://avatars.githubusercontent.com/u/75404713?v=4?s=100" width="100px;" alt="viiviii"/><br /><sub><b>viiviii</b></sub></a><br /><a href="https://github.com/jpoh281/flutter_korea_regexp/commits?author=viiviii" title="Code">💻</a> <a href="https://github.com/jpoh281/flutter_korea_regexp/commits?author=viiviii" title="Tests">⚠️</a> <a href="#ideas-viiviii" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://linktr.ee/jiiwon79"><img src="https://avatars.githubusercontent.com/u/59159410?v=4?s=100" width="100px;" alt="Lee Jiwon"/><br /><sub><b>Lee Jiwon</b></sub></a><br /><a href="https://github.com/jpoh281/flutter_korea_regexp/issues?q=author%3Ajiwon79" title="Bug reports">🐛</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
