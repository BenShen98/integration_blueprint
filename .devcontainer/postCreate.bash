#!/bin/bash
set +e

# normal postCreateCommand
# container install
python3 -m pip --disable-pip-version-check install --upgrade git+https://github.com/home-assistant/home-assistant.git@dev

# setup /config
hass -c /config --script ensure_config
mkdir -p /config/custom_components
touch /config/custom_components/__init__.py
ln -sf /workspaces/integration_blueprint/custom_components/integration_blueprint /config/custom_components/
ln -sf /workspaces/integration_blueprint/.devcontainer/configuration.yaml /config

# add pyscript custom_components
cd /workspaces && git clone https://github.com/custom-components/pyscript.git --depth 1
ln -s /workspaces/pyscript/custom_components/pyscript /config/custom_components/
pip install hass_pyscript_kernel
jupyter pyscript install

# MISC
git config --global user.email "docker@example.com"
git config --global user.name "docker"