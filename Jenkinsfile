pipeline { agent any stages { stage('instance11') { steps { sh '''terraform -chdir=/home/user/tf/instance1 init terraform -chdir=/home/user/tf/instance1 plan -out 
            /home/user/tf/instance1/config.tfplan terraform -chdir=/home/user/tf/instance1 apply -input=false /home/user/tf/instance1/config.tfplan'''
            }
        }
        stage('instance2') { steps { sh '''terraform -chdir=/home/user/tf/instance2 init terraform -chdir=/home/user/tf/instance2 plan -out /home/user/tf/instance2/config.tfplan terraform 
            -chdir=/home/user/tf/instance2 apply -input=false /home/user/tf/instance2/config.tfplan'''
            }
        }
    }
}
