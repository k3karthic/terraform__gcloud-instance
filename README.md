# Terraform - Deploy a single instance on Google Cloud

Deploy a single instance on Google Cloud running in the [Always Free](https://cloud.google.com/free) tier.

For more control over network security, deploy the instance into a custom Virtual Cloud Network using the Terraform script at [https://github.com/k3karthic/terraform__gcloud-vpc](https://github.com/k3karthic/terraform__gcloud-vpc).

For basic setup (swap, fail2ban), use the Ansible playbook at [https://github.com/k3karthic/ansible__freebsd-basic](https://github.com/k3karthic/ansible__freebsd-basic).

## Input Variables

Create a file to store the input variables using the sample file `uscentral.tfvars.sample`. The file should be called `uscentral.tfvars` or edit `bin/plan.sh` with the appropriate file name.

## Deployment

### Step 1

Create a Terraform plan by running plan.sh; the script will read input variables from the file uscentral.tfvars

```
./bin/plan.sh
```

To avoid fetching the latest state of resources from OCI, run the following command.

```
./bin/plan.sh --refresh=false
```

### Step 2

Review the generated plan

```
./bin/view.sh
```

### Step 3

Run the verified plan

```
./bin/apply.sh
```

## Encryption

Sensitive files like the input variables (uscentral.tfvars) and Terraform state files are encrypted before being stored in the repository.

You must add the unencrypted file paths to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```
