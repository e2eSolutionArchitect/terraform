'use strict';

var aws = require('aws-sdk');
aws.config.update({region: 'us-east-1'});

exports.handler = async (event, context,callback) => {
    var ssm= new aws.SSM();
    console.log('Received event:',JSON.stringify(event,null,2));
    const instanceId = event.detail.EC2InstanceId;
    console.log('instanceId:',instanceId);
    
    var params= {
        Documentation: "AWS-RunShellScript",
        InstanceIds: [instanceId],
        TimeoutSeconds: 30,
        Parameters: {
            'commands' : 'sudo /usr/local/bin/aws --region us-east-1 s3 cp /var/log/cloud-init.log s3://mybucket'}
        }
    const data = await ssm.sendCommand(params).promise()
    const response = {
        statusCode: 200,
        body: JSON.stringify('Run Command executed'),
    };
    console.log('data:',data);
    //return response;
    callback(null,'Finished')
};
