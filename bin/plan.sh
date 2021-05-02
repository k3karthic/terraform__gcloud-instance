#!/usr/bin/env bash

terraform plan -var-file=uscentral.tfvars --out=tf.plan $@
