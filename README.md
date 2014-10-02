# arm-chroot

We're testing [py3minepi](https://github.com/py3minepi/py3minepi) [inside an ARM chroot](https://github.com/py3minepi/py3minepi/blob/5df599d3c6bfa9003be67baff778428b5564973c/.travis-ci.sh) since that's about as close as we'll get to our target environment.

This takes about 15 minutes to build for each test run (where the tests themselves take under a minute) [which is somewhat slower than ideal](https://github.com/py3minepi/py3minepi/pull/28) particularly given multiple runs.

So, lets pre-build it!
