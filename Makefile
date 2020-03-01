SHELL=/bin/bash
.ONESHELL:
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
CONDA_ENV_NAME=jupyterlab-s3-browser
PYTHON_PACKAGE_NAME=jupyterlab_s3_browser

default: setup

setup: setup_conda_env build_lab_extension install_lab_extension

setup_conda_env:
	@conda env remove -n $(CONDA_ENV_NAME)
	@conda env create -f environment.yml
	@$(CONDA_ACTIVATE) $(CONDA_ENV_NAME)

build_lab_extension:
	@yarn install
	@yarn run build

install_lab_extension: build_lab_extension
	@echo "extension not compatible"
	@$(CONDA_ACTIVATE) $(CONDA_ENV_NAME) && jupyter labextension link .

install_server_extension:
	@$(CONDA_ACTIVATE) $(CONDA_ENV_NAME) && pip install . && jupyter labextension link . && jupyter serverextension enable --py $(PYTHON_PACKAGE_NAME)

test: setup
	@$(CONDA_ACTIVATE) $(CONDA_ENV_NAME) && coverage run -m pytest $(PYTHON_PACKAGE_NAME) && coverage report --fail-under 80

clean:
	@conda env remove -n $(CONDA_ENV_NAME)
	@rm -rf node_modules/
	@echo "cleaned!"
