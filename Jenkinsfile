def createImageShFile
def deployShFile
def artifactoryRepoUrl
def artifactoryRepoPath
def artifactoryServiceJar
def serviceJar

pipeline{
    agent any 

    stages{
        stage("Initialize"){
            steps{
                println "initializing .. updating the template with property values.. "

                script{
                    def props = readProperties file:'application.properties'
                    
                    artifactoryRepoUrl=props.PROP_ARTIFACTORY_REPO_URL
                    artifactoryRepoPath=props.PROP_ARTIFACTORY_PATH
                    artifactoryServiceJar=props.PROP_ARTIFACTORY_SERVICE_JAR
                    serviceJar=props.PROP_SERVICE_JAR

                    println "artifactoryRepoUrl=${artifactoryRepoUrl}"
                    println "artifactoryRepoPath=${artifactoryRepoPath}"
                    println "artifactoryServiceJar=${artifactoryServiceJar}"
                    println "serviceJar=${serviceJar}"
 
                    createImageShFile = 'create_image.sh'
                    def templateCreateImageFileText = readFile createImageShFile

                    deployShFile = 'deploy.sh'
                    def templateDeployFileText = readFile deployShFile

                    println 'Template File text:'
                    println templateCreateImageFileText
                    println '---------------'
                    println templateDeployFileText
                    println '---------------'

                    props.each{entry -> 
                        println entry.key + ':'+entry.value
                        templateCreateImageFileText = templateCreateImageFileText.replaceAll(entry.key, entry.value)
                        templateDeployFileText = templateDeployFileText.replaceAll(entry.key, entry.value)
                    }
                    
                    sh "rm -f ${createImageShFile}"
                    writeFile file: createImageShFile, text: templateCreateImageFileText 
                    sh "chmod +x ${createImageShFile}"
                    
                    sh "rm -f ${deployShFile}"
                    withCredentials([string(credentialsId: 'EY_DEV_FRANKFURT_CLUSTER_APIKEY', variable: 'api_key')]) {
                        templateDeployFileText = templateDeployFileText.replaceAll('EY_DEV_FRANKFURT_CLUSTER_APIKEY', api_key)
                        println '-----------------'
                        println templateDeployFileText
                        writeFile file: deployShFile, text: templateDeployFileText 
                        sh "chmod +x ${deployShFile}"
                    }
                }
            }
        }
        stage("Download Artifact from Artifactory"){
            steps{
                script{
                    echo "======== Downloading artifact from Artifactory ========"
                    sh "rm -f ${serviceJar}"
                    sh "ls -al"
                    withCredentials([usernamePassword(credentialsId: '6085f3e6-8e49-42b7-8092-2a78b19adcba', passwordVariable: 'apikey', usernameVariable: 'user')]) {
                        def cmd = "curl -k -u user:apikey ${artifactoryRepoUrl}/${artifactoryRepoPath}/${artifactoryServiceJar} -o ${serviceJar}" 
                        sh cmd
                    }
                    sh "ls -al"
                    println "----------  Artifact download done ---------"
                }
            }
        }
        stage("Create Image"){
            steps{
                echo "======== Creating Image ========"
                sh "./${createImageShFile}"
                println "----------  Image creation done ---------"
            }
        }
        stage("Deploy Service"){
            steps{
                echo "======== deploying ========"
                sh "./${deployShFile}"
                println '============== deployment done ========='
            }
        }
    }
}