# Install package
#install.packages("keyring")
# Load package
library(keyring)

# CMP database key setup
# View keys that have already been saved under cmpdb
keyring::key_list(service = "cmpdb")

# Set a key with a username and password for the CMP database
keyring::key_set(
  service = "cmpdb",
  username = "ENTER YOUR USERNAME HERE",
  prompt = "Enter your CMP Database Password: "
)

# Set the port number
keyring::key_set(
  service = "cmpdb",
  username = "port",
  prompt = "Enter the CMP Database Port Number: "
)

# Set the IP address
keyring::key_set(
  service = "cmpdb",
  username = "ip",
  prompt = "Enter the CMP Database IP address:"
)
