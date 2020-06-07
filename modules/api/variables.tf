variable "name" {
  description = "The name of the REST API"
}

variable "stage_name" {
  description = "The stage name for the API deployment (production/staging/etc..)"
}

variable "method" {
  description = "The HTTP method"
  default     = "GET"
}

variable "lambda" {
  description = "The lambda name to invoke"
}

variable "lambda_arn" {
  description = "The lambda arn to invoke"
}
