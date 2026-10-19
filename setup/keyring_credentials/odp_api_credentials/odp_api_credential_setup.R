# Install package
#install.packages("keyring")
# Load package
library(keyring)

# ODP API key setup
# View keys that have already been saved under cmpdb
keyring::key_list(service = "odp-api")

# Store your email used with your Open Data Portal Account
keyring::key_set(
  service = "odp-api",
  username = "email",
  prompt = "Enter your email for your Open Data Portal account: "
)

# Store the password used with your Open Data Portal Account
keyring::key_set(
  service = "odp-api",
  username = "password",
  prompt = "Enter your password for your Open Data Portal account: "
)

# Store an app token associated with accessing datasets on your Open Data Portal Account
keyring::key_set(
  service = "odp-api",
  username = "cmp-metric-app-token", # this can be modified to store different app tokens under different names
  prompt = "Enter the app token you would like to save: "
)
