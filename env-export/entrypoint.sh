#!/bin/sh
set -e

env_var_names=$(secrethub env ls)
echo "The following environment variables will be populated with secrets from SecretHub:"
echo "$env_var_names"

for var_name in $env_var_names; do
	secret_value=$(secrethub env read $var_name)
	echo "::add-mask::$secret_value"
	echo "::set-env name=$var_name::$secret_value"
done
