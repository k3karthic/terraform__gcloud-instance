# Terraform - Deploy a single instance in Google Cloud

A [Terraform](https://www.terraform.io/) script to deploy an instance in Google Cloud running under the [Always Free](https://cloud.google.com/free) tier.

A custom VPC allows for more control over network security. The Terraform script below creates a custom VPC,
* terraform__gcloud-vpc
    * GitHub: [github.com/k3karthic/terraform__gcloud-vpc](https://github.com/k3karthic/terraform__gcloud-vpc)
    * Codeberg: [codeberg.org/k3karthic/terraform__gcloud-vpc](https://codeberg.org/k3karthic/terraform__gcloud-vpc)

The following Ansible playbook covers the Basic setup (e.g. swap, fail2ban),
* ansible__freebsd-basic
    * GitHub: [github.com/k3karthic/ansible__freebsd-basic](https://github.com/k3karthic/ansible__freebsd-basic)
    * Codeberg: [codeberg.org/k3karthic/ansible__freebsd-basic](https://codeberg.org/k3karthic/ansible__freebsd-basic)

You can get a free static hostname for the instance using the Ansible playbook below,
* ansible__gcloud-ydns
    * GitHub: [github.com/k3karthic/ansible__gcloud-ydns](https://github.com/k3karthic/ansible__gcloud-ydns)
    * Codeberg: [codeberg.org/k3karthic/ansible__gcloud-ydns](https://codeberg.org/k3karthic/ansible__gcloud-ydns)

## Code Mirrors

* GitHub: [github.com/k3karthic/terraform__gcloud-instance](https://github.com/k3karthic/terraform__gcloud-instance/)
* Codeberg: [codeberg.org/k3karthic/terraform__gcloud-instance](https://codeberg.org/k3karthic/terraform__gcloud-instance/)

## Configuration

**Step 1:** Create a file to store the [Terraform input variables](https://www.terraform.io/docs/language/values/variables.html). Use `uscentral.tfvars.sample` as a reference. Keep `uscentral.tfvars` as the filename or change the name in the following files,
* `bin/plan.sh`

**Step 2:** Create a custom VPC and update the subnet name in `subnetwork`. To skip creating a VPC use `default` as the value.

**Step 3:** Create a hostname in [YDNS](https://ydns.io/) and update the same in `ydns_host`.

## Authentication

Documentation for the [HashiCorp Google provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs) is available at [registry.terraform.io/providers/hashicorp/google/latest/docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs).

[Google Cloud Shell](https://cloud.google.com/shell/) can deploy this this script without configuration.

## Deployment

**Step 1:** Use the following command to create a [Terraform plan](https://www.terraform.io/docs/cli/run/index.html#planning).
```
$ ./bin/plan.sh
```

To avoid fetching the latest state of resources, use the following command.
```
$ ./bin/plan.sh -refresh=false
```

**Step 2:** Review the plan using the following command.
```
$ ./bin/view.sh
```

**Step 3:** [Apply](https://www.terraform.io/docs/cli/run/index.html#applying) the plan using the following command.
```
$ ./bin/apply.sh
```

## Encryption

Encrypt sensitive files (input variables, [Terraform state](https://www.terraform.io/docs/language/state/index.html) files) before saving them. `.gitignore` must contain the unencrypted file paths.

You must add the unencrypted file paths to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
$ ./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
$ ./bin/encrypt.sh <gpg key id>
```
