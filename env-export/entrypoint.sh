#!/bin/sh
set -e

env_var_names=$(secrethub env ls)

for var_name in $env_var_names; do
	secret_value=$(secrethub env read $var_name)
	echo "::set-env name=$var_name::$secret_value"
	echo "::add-mask::$secret_value"
done
