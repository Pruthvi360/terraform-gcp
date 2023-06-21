variable "project_id" {
type =string
}


variable "machine_type" {
  description = "GCP VM instance machine type."
  type        = string
  default     = "n2-custom-10-71680"
}
