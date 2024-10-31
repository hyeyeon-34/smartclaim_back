# Jenkins LTS 버전 사용
FROM jenkins/jenkins:lts

# 종속성 설치
USER root  # 패키지 설치를 위해 root 사용자로 전환

# Node.js 설치
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

USER jenkins  # 다시 jenkins 사용자로 전환

# 작업 디렉토리 설정
WORKDIR /usr/src/app

# 패키지 파일 복사
COPY package.json ./
COPY package-lock.json ./  # lock 파일도 복사 (있다면)

# 종속성 설치
RUN npm install

# 소스 코드 복사
COPY . .

# 애플리케이션 실행 명령어
CMD ["node", "index.js"]

# 외부에 노출할 포트 설정
EXPOSE 8000
