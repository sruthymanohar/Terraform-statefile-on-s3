# Terraform state file on s3 backend 
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


When you  are building an infrastrucre using Iac tool terraform, a state file  is generated locally in the directory and it contains all the details about your infrastrure  that means it act as a database for your infrastrucre.This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment. 

Here in this project I have uploaded the tfstate file to  remote backup s3 bucket So we can easily manage state file.

## Prerequisites.
- S3 storage
- IAM user who have the  full privilleages to s3 bucket 

## Features
- Terraform writes the state data to a remote data store and it  make more easier to modify or    manage the infrastructure

```sh
To setup the tstate file in remote end initially we need an IAM user details wth s3 full access and s3 bucket
```
Here I have already created a s3 bucket  "remotetfstate" for my project and I'm setting the backend to s3

```sh 
terraform {
        backend "s3"{
        bucket      = "remotetfstate"
        key         = "terraform/terraform.tfstate"
        region      = "ap-south-1"
        encrypt     = false
        }
}
```

Now Backend initialization required, The "backend" is the interface that Terraform uses to store state, perform operations, etc.  The Terraform configuration that we are using is  a custom configuration for the Terraform backend. Changes to backend configurations require reinitialization. This allows terraform to set up the new configuration, copy existing state, etc. So Please run "terraform init" with either the "-reconfigure" or "-migrate-state" flags to
use the current configuration.

Output: 

```sh 
[root@ip-172-31-8-241 awsproject]# terraform init -reconfigure

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v3.56.0

Terraform has been successfully initialized!
```

Lets validate the terraform files using
```sh 
terraform validate
```

Lets plan the architecture and verify once again.

```sh
terraform plan
```
Lets apply the above architecture to the AWS.
```sh 
terraform apply
```
So lets first checkout our s3 bucket -



Here we can see that our state file is working fine in remote end s3  and locally you can see that it becomes an empty file.

```sh 
-rw-r--r-- 1 root root  199 Sep  1 17:32 main.tf
-rw-r--r-- 1 root root  143 Sep  1 13:36 provider.tf
-rw-r--r-- 1 root root    0 Sep  1 14:53 terraform.tfstate
-rw-r--r-- 1 root root 3809 Sep  1 14:53 terraform.tfstate.backup
[root@ip-172-31-8-241 awsproject]#
```

