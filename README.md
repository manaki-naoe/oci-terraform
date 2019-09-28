# oci-terraform

## Step.1

### Modify variable

| file                     | variable                      | value                                    |
| :----------------------- | :---------------------------- | :--------------------------------------- |
| common.tf                | compartment_ocid              | compartment OCID                         |
|                          | defined_tag                   | namespace.key                            |
|                          | defined_tag_value             | Tag value                                |
|                          | instance_ssh_public_key       | Public key value to pass to the instance |
| provaider-var.tf         | tenancy_ocid                  | tenancy OCID                             |
|                          | user_ocid                     | user OCID                                |
|                          | fingerprint                   | Public API key fingerprint               |
|                          | private_key_path              | private_key_path                         |
|                          | region                        | Select region                            |
| network.auto.tfvars      | vcn_cidr_block                | CIDR assigned to the VCN                 |
|                          | vcn_display_name              | Display name in the OCI console          |
|                          | vcn_dns_label                 | DNS label name of VCN                    |
|                          | internet_gateway_display_name | Display name in the OCI console          |
|                          | nat_gateway_display_name      | Display name in the OCI console          |
|                          | availability_domain           | Availability domain ID                   |
|                          | elb_subnet_cidr_block         | CIDR assigned to the subnet elb          |
|                          | admin_subnet_cidr_block       | CIDR assigned to the subnet admin        |
|                          | web_subnet_cidr_block         | CIDR assigned to the subnet web          |
|                          | db_subnet_cidr_block          | CIDR assigned to the subnet db           |
| adminservers.auto.tfvars | NumInstances_admin            | Number of instances                      |
|                          | instance_shape_admin          | The shape of the instance to create      |
|                          | instance_host_name_admin      | Instance host name                       |
|                          | instance_display_name_admin   | Display name in the OCI console          |
|                          | instance_volume_size_admin    | Instance root volume size                |
|                          | private_ip_admin              | Instance internal IP address             |
| webservers.auto.tfvars   | NumInstances_web              | Number of instances                      |
|                          | instance_shape_web            | The shape of the instance to create      |
|                          | instance_host_name_web        | Display name in the OCI console          |
|                          | instance_display_name_web     | Instance host name                       |
|                          | instance_volume_size_web      | Instance root volume size                |
|                          | private_ip_web                | Instance internal IP address             |
| dbservers.auto.tfvars    | NumInstances_db               | Number of instances                      |
|                          | instance_shape_db             | The shape of the instance to create      |
|                          | instance_host_name_db         | Display name in the OCI console          |
|                          | instance_display_name_db      | Instance host name                       |
|                          | instance_volume_size_db       | Instance root volume size                |
|                          | private_ip_db                 | Instance internal IP address             |

### Other changes

Change the instance image to the desired ID

```Terra
variable "instance_image_ocid_web" {
  type = "map"
  default = {
    ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayxjigcwqiqjncbkm7yxppjqfzsjnbvtjsemrvnwrtpwynausossa"
  }
}
```

Customize as you like.

## Step.2

### Run on terraform

Run in the environment → production

```bash
$ cd oci-terraform/environment/production
$ terraform init

Initializing the backend...

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking  
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings    
suggested below.

* provider.oci: version = "~> 3.36"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see  
any changes that are required for your infrastructure. All Terraform commands  
should now work.

If you ever set or change modules or backend configuration for Terraform,      
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.


$ terraform plan -out=test
~~~~~~~~~~~~~~~~~~~~~
This plan was saved to: test

To perform exactly these actions, run the following command to apply:
    terraform apply "test"


$ terraform apply "test"
```