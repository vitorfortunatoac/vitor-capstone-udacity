#!/bin/bash

    aws cloudformation create-stack \
    --stack-name udacity-final-project-vitor-jenkins \
    --template-body file://jenkins.yml \
    --parameters file://parameters-jenkins.json  \
    --region=eu-central-1 \
    --capabilities CAPABILITY_NAMED_IAM