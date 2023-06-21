## Requirement of the main VM:

1. Virtualization should be Enabled

# Steps to Enabled Nested Virtualization in GCP VM instance
```
gcloud compute instances create nested --zone=us-central1-a --machine-type=n1-standard-1 --min-cpu-platform=Intel\ Haswell --create-disk=auto-delete=yes,boot=yes,device-name=nested,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20230617,mode=rw,size=10,type=projects/sdcloud-beta1/zones/us-central1-a/diskTypes/pd-ssd
```
# 1. Create GCP Instance
```
OS = Ubuntu 22.04
Disk = 10 GB disk
Machine-Type = N1
CPU Type = Intel Haswell
```
# 2. Create a Custom Image out of GCP instance
```
gcloud compute images create ubuntu-22-04-nested-vm-image \
--source-disk=nested --source-disk-zone=us-central1-a \
 --licenses="https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
```

# 3. Use Created custom image and launch instance Except for E2 machine 
```
Use Terraform script
```
# 4. git clone

```
git clone https://github.com/Pruthvi360/terraform-gcp.git
cd /terraform-gcp/gcp-libvirt-vm/gcp-main-vm
terraform init
terraform plan -var project_id="<your-project-id>"
terraform apply -var project_id="<your-project-id>" -auto-approve
```

# Check the VM creation

```
virsh list --all
virsh net-dhcp-leases default
```
