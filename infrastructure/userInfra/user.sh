#!/bin/bash

aws cloudformation create-stack \
--stack-name udacity-final-project-vitor \
--template-body file://user.yml \
--region=eu-central-1 \
 --capabilities CAPABILITY_NAMED_IAM


