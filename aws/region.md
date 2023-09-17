// [.root](../root.md) / [.aws](./aws.md) /

# .region

Amazon Web Services (AWS)

## Usage

```
tfadm COMMAND [OPTIONS] .aws [{environment}/{region}]...
tfadm COMMAND [OPTIONS] .aws [{domain}]...
```

## Methods

### sync.describe()

```bash
aws ec2 describe-regions --profile "{profile}" --region "eu-west-1" --region-names "{region}" --query "Regions" --no-paginate --output json || \
aws ec2 describe-regions --profile "{profile}" --region "eu-west-1" --query "Regions" --no-paginate --output json
```
