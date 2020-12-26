output "public_key_pem" {
  value = tls_private_key.public_private_key_pair.public_key_pem
}

output "private_key_pem" {
  value = tls_private_key.public_private_key_pair.private_key_pem
}

output "public_key_openssh" {
  value = tls_private_key.public_private_key_pair.public_key_openssh
}
