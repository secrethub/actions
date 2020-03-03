#!/bin/sh
set -e

env_var_names=$(secrethub env ls)
echo "The following environment variables will be populated with secrets from SecretHub:"
echo "$env_var_names"

for var_name in $env_var_names; do
	secret_value=$(secrethub env read $var_name)

	# Escape percent signs and add a mask per line (see https://github.com/actions/runner/issues/161)
	escaped_mask_value=$(echo "$secret_value" | sed -e 's/%/%25/g')
	IFS=$'\n'
	for line in $escaped_mask_value; do
		echo "::add-mask::$line"
	done
	unset IFS

	# Escape percent signs and newlines when setting the environment variable
	escaped_env_var_value=$(echo -n "$secret_value" | sed -z -e 's/%/%25/g' -e 's/\n/%0A/g')
	echo "::set-env name=$var_name::$escaped_env_var_value"
done
