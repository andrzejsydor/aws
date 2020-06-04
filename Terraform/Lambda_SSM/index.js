var AWS = require('aws-sdk');
var ssm = new AWS.SSM();

exports.handler = function(event, context) {
    // TODO implement
    
    getParameterFromSystemManager(function(){
        console.log('done');
        context.done(null, 'Hello from Lambda');
    });

};

function getParameterFromSystemManager(callback) {

    // Fetches a parameter called REPO_NAME from SSM parameter store.
    // Requires a policy for SSM:GetParameter on the parameter being read.
    var params = {
        Name: '/dev/secret_string_name',
        WithDecryption: true /* required */
    };

    var request = ssm.getParameter(params, function(err, data) {
        if (err) 
            console.log(err, err.stack);
        else 
            console.log(data);
        
        callback();
    });
}
