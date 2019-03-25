# aws-nginx
## How to setup the app on your machine
- Create an [AWS](https://en.wikipedia.org/wiki/Amazon_Web_Services) account [here](https://aws.amazon.com/), ensure you have your atm card nearby.
- On succesful creation of account, click on services and select EC2
- Follow this [tutorial](https://docs.aws.amazon.com/efs/latest/ug/gs-step-one-create-ec2-resources.html) to create an EC2 instance 🕺🏻, after successfully creating an instance you will get a private key file
- Launch the terminal and ssh into that instance i.e ```ssh -i "example.pem" ubuntu@ec2-3-18-213-13.us-east-2.compute.amazonaws.com```
- Clone the repository with the command ```git clone https://github.com/abejide001/aws-nginx.git```
- cd into the repository
- Create a .env file, copy the content of the .env.sample and edit to your taste 😀
- Run the script with the command ``` sudo ./app.sh ```
- Register and Create a domanin name with any name of your choice on [Freenom](freenom.com)
- Select Route53 from services and create an hosted zone, and also create a record set with this [tutorial](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)
- Copy the values for the name server on aws and paste in freenom
- Now you should be able to access the domain created
