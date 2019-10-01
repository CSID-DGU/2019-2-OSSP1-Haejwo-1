# YUI 템플릿 확인

http://localhost:3000/yui/

# master.key 다시 생성하기

프로젝트 처음 생성한 후
기존 credentials.yml.enc 삭제

EDITOR=vim rails credentials:edit
:wq로 나가면 master.key 생성되어 있음.
테스트 서버에 master.key를 넣어야 배포가 됨
