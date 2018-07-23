# Cloudnet '18 training labs - Network Services

[DIAGRAM]

### Running the Script

Run Terraform as follows:
```sh
terraform plan
terraform apply
```
You will get an error message as managed instance groups instances are still being created before the routes try to reference them as next hop. Error might look like this:

```sh
${lookup(data.google_compute_region_instance_group.natgw_mig.instances[count.index], "instance")}
* google_compute_route.dev_nat_routes[0]: At column 71, line 1: list "data.google_compute_region_instance_group.natgw_mig.instances" does not have any elements so cannot determine type. in:
```

Not to worry! Just run terraform again after a minute and the managed group instance data output will be available to be referenced by the routes.

```sh
terraform plan
terraform apply
```

[DIAGRAM]: <https://codelabs.developers.google.com/codelabs/cloudnet18-network-services/img/a92d0ba83071db16.png>
