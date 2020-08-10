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
conda build ${INPUT_CHANNEL_OPTS} --output-folder . ${RECIPE_DIR}

# upload anaconda package
export ANACONDA_API_TOKEN=${INPUT_ANACONDATOKEN}


if [ -z "${INPUT_PACKAGENAME}" ]
then
      anaconda upload --label main ./noarch/*.tar.bz2 
else
      anaconda upload --label main ./noarch/${INPUT_PACKAGENAME}*.tar.bz2
fi

