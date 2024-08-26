pipeline {
    agent any
    stages {
        stage('Scan & Review with Sonar') {
            steps {
                withSonarQubeEnv(installationName: 'sonar') {
                    sh 'mvn clean package sonar:sonar   -Dsonar.projectKey=Basic-Maven   -Dsonar.projectName=\'Basic Maven\'   -Dsonar.host.url=http://localhost:9000   -Dsonar.token=sqp_1d0b485eaa6f5a8028690c8983d8fd0c74490278'
                }
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn --version'
                sh 'mvn -B -DskipTests clean package' 
                stash includes : 'target/*.jar', name: 'app'
            }
        }
        stage('Pakage with Docker') {
            steps {
                unstash 'app'
                sh 'ls -la'
                sh 'ls -la target'
                sh 'docker build -t maven-simple-image:1.1 .'
            }
        }
    }
}
