#!/bin/bash

AWS_REGION=ap-northeast-1
VPC_ID=vpc-0bbc0d2503aa859c2
PUBLIC_SUBNET1=subnet-03f76a89b8562e8d5
PUBLIC_SUBNET2=subnet-0d9857314281d82fe
ECS_EXEC_BUCKET_NAME=larasample-949615757
KMS_KEY=$(aws kms create-key --region $AWS_REGION)
KMS_KEY_ARN=$(echo $KMS_KEY | jq --raw-output .KeyMetadata.Arn)


aws kms create-alias \
	--alias-name alias/larasample-kms-key \
	--target-key-id $KMS_KEY_ARN \
	--region $AWS_REGION

echo "The KMS Key ARN is: "$KMS_KEY_ARN 

aws ecs create-cluster \
    --cluster-name larasample-cluster \
    --region $AWS_REGION \
    --configuration executeCommandConfiguration="{\
    	logging=OVERRIDE,\
        kmsKeyId=$KMS_KEY_ARN,\
        logConfiguration={\
        	cloudWatchLogGroupName="/aws/ecs/larasample",\
        	s3BucketName=$ECS_EXEC_BUCKET_NAME,\
        	s3KeyPrefix=exec-output\
	    }\
	}"

aws logs create-log-group \
	--log-group-name /aws/ecs/larasample \
	--region $AWS_REGION

aws s3api create-bucket \
	--bucket $ECS_EXEC_BUCKET_NAME \
	--region $AWS_REGION \
	--create-bucket-configuration LocationConstraint=$AWS_REGION 

ECS_EXEC_SG=$(\
	aws ec2 create-security-group \
		--group-name larasample-SG \
		--description "ECS larasample SG" \
		--vpc-id $VPC_ID \
		--region $AWS_REGION) 

ECS_EXEC_SG_ID=$(echo $ECS_EXEC_SG | jq --raw-output .GroupId)

aws ec2 authorize-security-group-ingress \
	--group-id $ECS_EXEC_SG_ID \
	--protocol tcp \
	--port 80 \
	--cidr 0.0.0.0/0 \
	--region $AWS_REGION 
  
aws iam create-role \
	--role-name larasample-task-execution-role \
	--assume-role-policy-document file://ecs-tasks-trust-policy.json \
	--region $AWS_REGION

aws iam create-role \
	--role-name larasample-task-role \
	--assume-role-policy-document file://ecs-tasks-trust-policy.json \
	--region $AWS_REGION


# Attach a policy
aws iam attach-role-policy \
    --role-name larasample-task-execution-role \
    --policy-arn "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
aws iam attach-role-policy \
    --role-name larasample-task-execution-role \
    --policy-arn "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"

aws iam put-role-policy \
    --role-name larasample-task-role \
    --policy-name ecs-exec-demo-task-role-policy \
    --policy-document file://$(pwd)/ecs-exec-demo-task-role-policy.json


# Register a task definition
aws ecs register-task-definition \
    --cli-input-json file://$(pwd)/ecs-task-definition-for-larasample.json \
    --region $AWS_REGION
