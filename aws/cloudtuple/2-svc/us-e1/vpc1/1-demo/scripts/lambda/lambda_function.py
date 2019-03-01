import boto3

sns = boto3.client('sns')

def handler(event,context):
    sns.publish(
        TopicArn='SNS_TOPIC_ARN_HERE',
        Message=(
            'Hello!'
            'Your children are not your children!'
            'They are the sons and daughters of Life\'s longing for itself'
        )
    )
    return 'success'
