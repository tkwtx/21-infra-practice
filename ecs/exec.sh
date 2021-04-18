#!/bin/bash
TASK_ID=$1

aws ecs execute-command  \
    --region $AWS_REGION \
    --cluster larasample-cluster \
    --task $TASK_ID \
    --container laravel \
    --command "/bin/bash" \
    --interactive