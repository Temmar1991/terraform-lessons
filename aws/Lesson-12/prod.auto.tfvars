region = "ca-central-1"
instance_type = "t2.small"
enable_detailed_monitoring = true

common_tags = {
        Owner = "Artem Melnyk"
        Project = "Phoenix"
        CostCenter = 12345
        Environment = "production"
}

allow_ports = ["80", "443"]
