#!/bin/bash

set -ex
set -o pipefail

# if subdir is not set use conda-recipe subdirectory as default
RECIPE_DIR=${INPUT_SUBDIR}

# check if setup.py file exists
if [ ! -f setup.py ]; then
    echo "setup.py does not exist"
    exit 1
fi

# check if meta yaml file exists
RECIPE_META_YAML=${RECIPE_DIR}/meta.yaml
if [ ! -f ${RECIPE_META_YAML} ]; then
    echo "${RECIPE_META_YAML} does not exist"
    exit 1
fi

# build conda package
conda build -c paulscherrerinstitute --output-folder . ${RECIPE_META_YAML}

# upload anaconda package
export ANACONDA_API_TOKEN=${INPUT_ANACONDATOKEN}
anaconda upload --label main ./noarch/*.tar.bz2
