pipeline{
    agent any

    tools{
        maven "Maven"
    }
    environment {
        GOREST_TOKEN = credentials('gorest-token')   
    }
    options {
        timeout(time: 15, unit: 'MINUTES')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }
    stages {

        stage('Build & Test') {
            steps {
                echo 'Ejecutando pruebas Karate...'
                sh 'mvn -B clean test'
            }
        }

    }

    post {
        always {
            echo 'Publicando reporte HTML de Karate...'
            junit testResults: 'target/karate-reports/*.xml', allowEmptyResults: true
            publishHTML([
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'target/karate-reports',
                reportFiles: 'karate-summary.html',
                reportName: 'Reporte de Pruebas Karate'
            ])
            
        }
        success {
            echo 'Pruebas Karate ejecutadas con éxito.'
        }
        failure {
            echo 'Falló alguna etapa del pipeline.'
        }
        cleanup{
            echo 'Pipeline finalizado — limpiando workspace.'
            cleanWs()
        }
    }
}