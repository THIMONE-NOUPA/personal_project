# Get the root directory of the repository
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$REPO_ROOT" ]; then
    echo "Not a git repository or unable to determine repository root."
    exit 1
fi

# Delete terraform directories and files
find "./terra-jenkins/jenkins_server" -type d -name '.terraform' -exec rm -rf {} \;
find "./terra-jenkins/jenkins_server" -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "./terra-jenkins/jenkins_server" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "./terra-jenkins/jenkins_server" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;

find "./terra-jenkins/sonar_server" -type d -name '.terraform' -exec rm -rf {} \;
find "./terra-jenkins/sonar_server" -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "./terra-jenkins/sonar_server" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "./terra-jenkins/sonar_server" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;

find "./terra-jenkins/spring_network" -type d -name '.terraform' -exec rm -rf {} \;
find "./terra-jenkins/spring_network" -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "./terra-jenkins/spring_network" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "./terra-jenkins/spring_network" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;

find "./terra-jenkins/bastion_host" -type d -name '.terraform' -exec rm -rf {} \;
find "./terra-jenkins/bastion_host" -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "./terra-jenkins/bastion_host" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "./terra-jenkins/bastion_host" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;

find "./terra-jenkins/s3_backend" -type d -name '.terraform' -exec rm -rf {} \;
find "./terra-jenkins/s3_backend" -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "./terra-jenkins/s3_backend" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "./terra-jenkins/s3_backend" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;

find "." -type d -name '.terraform' -exec rm -rf {} \;
find "." -type f -name 'terraform.tfstate' -exec rm -f {} \;
find "." -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;
find "." -type f -name '.terraform.lock.hcl' -exec rm -f {} \;
find "." -type f -wholename './ec2-intance/.terraform/providers/registry.terraform.io/hashicorp/aws/5.72.0/windows_amd64/terraform-provider-aws_v5.72.0_x5.exe' -exec rm -f {} \;

echo "Cleanup complete."