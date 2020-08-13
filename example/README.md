# Teffaform Stateful Lambda API Example

This is a simple example for creating a serverless API with EFS file system for persistent file storage.

## How to deploy? 

```bash
terraform init
terraform plan 
terraform apply
```

## How to test? 

### write a message
```
curl --location --request POST '<api endpoint>/dev/msg' \
--header 'Content-Type: application/json' \
--data-raw '{
	"msg": "hello"
}'
```

### read messages 
```
curl --location --request GET '<api endpoint>/dev/msg' 
```

### delete all messages
```
curl --location --request DELETE '<api endpoint>/dev/msg' 
```
