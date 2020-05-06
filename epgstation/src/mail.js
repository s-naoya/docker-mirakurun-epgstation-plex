const conf = JSON.parse(require("fs").readFileSync("/usr/local/EPGStation/config/mail_conf.json", "utf8"))

var subject = "[EPGStation] " + process.argv[2]
var text = Date().toLocaleString("ja") + "\n" + process.argv[3] + ": " + process.env.NAME

var nodemailer = require('nodemailer');
var transporter = nodemailer.createTransport({
  host: conf["SMTP_SERVER"],
  port: conf["SMTP_PORT"],
  secure: false,
  tls: {
    rejectUnauthorized: false
  }
});
var mailOptions1 = {
  from: conf["SMTP_FROM_ADDRESS"],
  to: conf["SMTP_TO_ADDRESS"],
  subject: subject,
  text: text
};
transporter.sendMail(mailOptions1, function (error, info) {
  if (error) {
    throw error;
  } else {
    console.log('Email sent: ' + info.response);
  }
});

