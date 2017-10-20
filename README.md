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
1. Create DynamoDB to show the general concept of AWS services
2. Theory EC2
3. Create VPC
4. Deploy debug security group
5. Deploy [yocto](https://github.com/felixb/yocto-httpd)
   * auto scaling group
   * SSH access
   * ELB deployment
     * [Hint 1](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html)
     * [Hint 2](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html)
   * Experts would remove the direct instance access via port 8080 now
   * Theory DNS
   * Create your own DNS entry
     * [Hint1](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53-hostedzone.html)
     * [Hint2](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html)
6. Autoscaling with [JMeter](http://jmeter.apache.org/download_jmeter.cgi)
   * Short introduction to EC2 instance types
   * Autoscaling with CloudWatch alarms
     * [Hint1](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cw-alarm.html)
     * [Hint2](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html)

## 3. Lambda Codelab
1. Create DynamoDB to show the general concept of AWS services
2. Theory Lambda
3. Deploy hello world example
   * Testing
   * Make it a real hello world with at least one input parameter
4. Chat
   * Deploy dynamoDb
   * Implement, deploy and test read chat lambda
     * [Hint1](http://docs.aws.amazon.com/lambda/latest/dg/programming-model.html)
     * [Hint2](http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/DynamoDB.html)
   * Implement, deploy and test write chat lambda
     * [Hint1](http://docs.aws.amazon.com/lambda/latest/dg/programming-model.html)
     * [Hint2](http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/DynamoDB.html)
   * Deploy and test chat API (only read implemented)
   * Implement, deploy and test write API method
     * [Hint](http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html#input-variable-reference)
5. Expert challenge: If you change the dynamoDb table name, it should be at one position (`chat-resources.yaml`).
   Currently you have to change it at three positions.

## 4. Useful Links:
* AWS Cloudformation Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html
* AWS IAM Policy Generator: https://awspolicygen.s3.amazonaws.com/policygen.html
* EC2 Instances pricing overview: http://www.ec2instances.info/?region=eu-central-1