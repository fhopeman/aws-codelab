# AWS codelab
Provides aws codelab challenges ..

## 1. Preparation
### 1.1 Tools
1. Ruby, version >=2.0.0 (https://rvm.io/rvm/install)
2. Bundler `gem install bundler` (https://bundler.io/)
3. AWS CLI (https://aws.amazon.com/de/cli/)
4. cli53 (optional, https://github.com/barnybug/cli53#installation)
### 1.2 Install autostacker24
Run `bundle install` in the root directory to install [autostacker24](https://github.com/AutoScout24/autostacker24).

## 2. EC2 Codelab
1. Create DynamoDB to show the general concept of AWS services.
2. Theory EC2
3. Create VPC
4. Deploy yocto
  - auto scaling group
  - SSH access
  - ELB deployment
    - [Hint 1](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html)
    - [Hint 2](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html)
  - Theory DNS
  - DNS
    - [Hint](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html)
5. Autoscaling with [jmeter](http://jmeter.apache.org/download_jmeter.cgi)
  - Short introduction to EC2 instance types
  - Autoscaling with CloudWatch alarms
    - [Hint1](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cw-alarm.html)
    - [Hint2](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html)

## 3. Lambda Codelab
