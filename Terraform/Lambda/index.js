exports.handler = (event, context, callback) => {
    console.log('Hello, logs!');
    let VAR1 = process.env.VAR1
    console.log('VAR1= ' + VAR1)
    callback(null, 'great success');
}
