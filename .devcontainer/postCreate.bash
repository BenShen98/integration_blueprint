#!/bin/bash
set +e

# normal postCreateCommand
container install

# fix symbolic link to custom_components
rm /config/custom_components
mkdir /config/custom_components
touch /config/custom_components/__init__.py
ln -s /workspaces/integration_blueprint/custom_components/integration_blueprint /config/custom_components/

# add pyscript custom_components
cd /workspaces && git clone https://github.com/custom-components/pyscript.git --depth 1
ln -s /workspaces/pyscript/custom_components/pyscript /config/custom_components/
pip install hass_pyscript_kernel
jupyter pyscript install