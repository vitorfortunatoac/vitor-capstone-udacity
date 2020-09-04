aws cloudformation create-stack --stack-name udacity-final-project-vitor-network \
--template-body file://network.yml  \
--parameters file://parameters.json \
--region=eu-central-1 \
--capabilities CAPABILITY_NAMED_IAM
