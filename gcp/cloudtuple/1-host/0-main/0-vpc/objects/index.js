const request = require('request');

const options = {
    url: 'http://10.100.10.101/',
    method: 'GET',
    headers: {
        'Accept': 'application/json',
        'Accept-Charset': 'utf-8',
        'User-Agent': 'salawu'
    }
};

exports.serverless = (req, res) => {
  request(options, function (error, response, body) {
    console.log('error:', error);
    console.log('statusCode:', response.statusCode);
    console.log('body:', body);
    res.send(body);
  });
};
