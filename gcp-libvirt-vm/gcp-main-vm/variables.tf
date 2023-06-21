variable "project_id" {
type =string
}

provider "google" {
  credentials = file("service-account.json")
}

variable "machine_type" {
  description = "GCP VM instance machine type."
  type        = string
  default     = "n2-custom-10-71680"
}
