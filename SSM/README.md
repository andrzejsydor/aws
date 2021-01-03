# SSM

[I install AWS Systems Manager Agent (SSM Agent) on an Amazon EC2 Linux instance at launch](https://aws.amazon.com/premiumsupport/knowledge-center/install-ssm-agent-ec2-linux/)

```sh
#!/bin/bash
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
```

[Adding Session Manager permissions to an existing instance profile](https://docs.aws.amazon.com/systems-manager/latest/userguide/getting-started-add-permissions-to-existing-profile.html)

[Manually install SSM Agent on EC2 instances for Linux](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-manual-agent-install.html)

