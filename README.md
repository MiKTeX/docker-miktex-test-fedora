# Fedora 38 docker image with MiKTeX test environment

## Obtaining the image

Get the latest image from the registry:

    docker pull miktex/miktex-test-fedora:38

or build it yourself:

    docker build --tag miktex/miktex-test-fedora:38 .

## Using the image

### Prerequisites

The directory containing the MiKTeX test suite must be mounted to the container
path `/miktex/test-suite`.  You can obtain the test suite from
[GitHub](https://github.com/MiKTeX/miktex-testing).

The test directory (where the tests are run) must be mounted to the container
path `/miktex/test`.

Optional: The directory containing the `.rpm` package file must be mounted to
`/miktex/build`.  If this directory is not mounted then the package will be
installed from the official source.

You should specify a user by setting the container environment variables
`USER_ID` and `GROUP_ID`.

### Example

Run the tests:

    git clone https://github.com/MiKTeX/miktex-testing ~/work/miktex/test-suite
    docker run --rm -t \
      -v ~/work/miktex/test-suite:/miktex/test-suite:ro \
      -v ~/work/miktex/tests/fedora-38:/miktex/test:rw \
      -e USER_ID=`id -u` \
      -e GROUP_ID=`id -g` \
      miktex/miktex-test-fedora:38
