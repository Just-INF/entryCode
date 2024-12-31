const nodemailer = require('nodemailer');
const fs = require('fs');
const createAccountTemplate = fs.readFileSync('src/Auth/emailStructure/createAccountTemplate.html', 'utf8');




// Create a transporter object using the default SMTP transport
let transporter = nodemailer.createTransport({
  service: 'gmail', // Use Gmail service
  host: "smtp.gmail.com",
  port: 587,
  auth: {
    user: 'contact.entrycode@gmail.com', // Your email address
    pass: 'wunh ocxk jsfe lxmz' // Your email password or app password
  }
});



function createNewAccountPin(userEmail,pin) {
    const customizedHtml = createAccountTemplate.replace('{{PIN}}', pin);
    // Set up email data
    let mailOptions = {
      from: 'contact.entrycode@gmail.com', // Sender address
      to: userEmail, // List of receivers
      subject: 'Create New Account', // Subject line
      text: "Hi, there, it seems that your browser/app can't read HTML so this may seem a little blank. Whatever, here is your pin: " + pin, // Plain text body
      html: customizedHtml // HTML body
    };
    //Send mail
    transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
        return console.log('Error occurred:', error);
    }
    console.log('Message sent:', info.response);
    });
    console.log("Email sent to ",  userEmail, ", pin : ",  pin)
}



function forgotPasswordPin(userEmail,pin) {
    // Set up email data
    let mailOptions = {
      from: 'contact.entrycode@gmail.com', // Sender address
      to: userEmail, // List of receivers
      subject: 'Hello ✔', // Subject line
      text: 'Hello world?', // Plain text body
      html: '<b>Hello world?</b>' // HTML body
    };

    /*//Send mail
    transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
        return console.log('Error occurred:', error);
    }
    console.log('Message sent:', info.response);
    });*/
    console.log("Email sent to ",  userEmail, ", pin : ",  pin)
}

module.exports = { createNewAccountPin, forgotPasswordPin };
