pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ye0nuk/opensource9"  // Docker 이미지 이름
        DOCKER_CREDENTIALS = "ye0nuk"  // Docker Hub 자격 증명 ID (Jenkins에서 설정)
    }

    stages {
        stage('Clone Repository') {
            steps {
                // GitHub에서 프로젝트를 클론
                git 'https://github.com/jieun728/OpenSource9.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Docker 이미지를 빌드
                    app = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").inside {
                        sh 'npm install'
                    }
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    // Docker 컨테이너 내부에서 테스트 실행
                    app.inside {
			sh 'npm run start & sleep 30'  //30초간 서버 실행
			sh 'pkill node'  // 서버 종료
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Docker Hub에 로그인 후 이미지를 푸시
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS) {
                        app.push("${env.BUILD_NUMBER}")  // 빌드 번호를 태그로 사용
                        app.push("latest")  // 최신 태그로 푸시
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Build, Test, and Push were successful!"
        }
        failure {
            echo "The pipeline failed. Please check the logs."
        }
    }
}
