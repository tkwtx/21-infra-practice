aws ecs create-service \
	--cluster larasample-cluster \
	--service-name larasample \
	--task-definition larasample\
	--enable-execute-command \
	--launch-type FARGATE \
	--load-balancers '[{"containerName":"nginx","containerPort":80,"targetGroupArn":"arn:aws:elasticloadbalancing:ap-northeast-1:089000569075:targetgroup/larasample/7aef36e544711858"}]' \
	--desired-count 2 \
	--network-configuration awsvpcConfiguration="{subnets=[$PUBLIC_SUBNET1, $PUBLIC_SUBNET2],securityGroups=[sg-094686921ffcfdf15],assignPublicIp=ENABLED}"