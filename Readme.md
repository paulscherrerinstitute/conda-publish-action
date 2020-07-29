# Overview

This is a Github-Action to build and publish conda packages.

### Example workflow to publish to conda every time you make a new release

```yaml
name: conda_publish

on:
  release:
    types: [published]
    
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: publish-to-conda
      uses: paulscherrerinstitute/conda-publish-action@master
      with:
        subdir: 'conda-recipe'
        anacondatoken: ${{ secrets.ANACONDA_TOKEN }}
        packagename'<INSERT_HERE_PACKAGE_NAME>'
```

### Example project structure

```
.
├── LICENSE
├── README.md
├── setup.py
├── myproject
│   ├── __init__.py
│   └── myproject.py
├── conda-recipe
│   ├── conda_build_config.yaml
│   └── meta.yaml
├── .github
│   └── workflows
│       └── publish_conda.yml
├── .gitignore
```

### ANACONDA_TOKEN

1. Get an Anaconda token (with read and write API access) at `anaconda.org/USERNAME/settings/access` 
2. Add it to the Secrets of the Github repository as `ANACONDA_TOKEN`
3. Add your package name to the variable packagename in your publish_conda.yml

# Acknowledgements
Most of this code is "copied" from https://github.com/fcakyon/conda-publish-action/
