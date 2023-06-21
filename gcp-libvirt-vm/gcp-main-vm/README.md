## Requirement of the main VM:

1. Virtualization should be Enabled

# Steps to Enabled Nested Virtualization in GCP VM instance
```
gcloud compute instances create nested --zone=us-central1-a --machine-type=n1-standard-1 --min-cpu-platform=Intel\ Haswell --create-disk=auto-delete=yes,boot=yes,device-name=nested,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2204-jammy-v20230617,mode=rw,size=10,type=projects/sdcloud-beta1/zones/us-central1-a/diskTypes/pd-ssd 
1. Create GCP Instance
```
OS = Ubuntu 22.04
Disk = 10 GB disk
Machine-Type = N1
CPU Type = Intel Haswell
```
2. Create a Custom Image out of GCP instance
```
gcloud compute images create nested-vm-image \
--source-disk=nested --source-disk-zone=us-central1-b \
 --licenses="https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
```
