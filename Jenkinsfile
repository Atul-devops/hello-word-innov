node
{
stage ('SCM Checkout')
{
   git 'https://github.com/Atul-devops/maven-project.git'
   }
   
stage ('package stage')
{
sh label: '', script: 'mvn clean package'
   }
   
stage ('docker image build') 
{
sh 'docker build -t atul0407/atul-app:0.1 .'
   }
   
   
	stage ('Push Docker image to DockerHub') 
	{
	 withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', passwordVariable: 'dockerHubAccount', usernameVariable: 'dockerHubAccount')])  {
	     sh "docker login -u atul0407 -p ${dockerHubAccount}"
	     }
	   sh 'docker push atul0407/atul-app:0.1'
  }
	
       stage('Remove Old Containers'){
           sshagent(['deploy-to-dev-docker']) {
             try{
               def sshCmd = 'ssh -o StrictHostKeyChecking=no ec2-user@3.129.62.58'
               def dockerRM = 'docker rm -f my-tomcat-app'
                 sh "${sshCmd} ${dockerRM}"
                 }catch(error){

      }
    }
  }
  
   
   stage ('Deploy to Dev') 
   {
def dockerRun = 'docker run -d -p 9000:8080 --name my-tomcat-app atul0407/atul-app:0.1'
sshagent(['deploy-to-dev-docker']) 
{
sh "ssh -o StrictHostKeyChecking=no ec2-user@3.129.62.58 ${dockerRun}"
    }
 }
}
