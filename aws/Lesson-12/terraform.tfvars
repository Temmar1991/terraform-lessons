region = "ca-central-1"
instance = "t2.micro"
enable_detailed_monitoring = false

common_tags = {
        Owner = "Artem Melnyk"
        Project = "Phoenix"
        CostCenter = 12345
        Environment = "development"
}

allow_ports = ["80", "22", "8080"]
