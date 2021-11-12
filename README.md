# Ledger TON app

## Overview
Ledger TON app for Ledger Nano S/X

P.S. Side-loading app isn't available for Nano X...

## Building and installing

Install prerequisite and use `prepare-devenv.sh`:

```bash
sudo apt install gcc make gcc-multilib g++-multilib libncurses5
sudo apt install python3-venv python3-dev libudev-dev libusb-1.0-0-dev
sudo apt-get install libc6-dev gcc-multilib g++-multilib

chmod +x ./prepare-devenv.sh
./prepare-devenv.sh
```

Sourcing the envs (with the right target (s or x)):

```
# (s or x, depending on your device)
source source-env.sh s 
```

Set udev rules:

Go to links below for more info:
https://github.com/obsidiansystems/ledger-app-tezos#udev-rules-linux-only


To fix problems connecting to Ledger follow this [guide](https://support.ledger.com/hc/en-us/articles/115005165269-Fix-connection-issues) (Open the Linux dropdown list at bottom of the page).

Compile and load the app onto the device:
```bash
make load
```

Refresh the repo (required after Makefile edits):
```bash
make clean
```
> An "arm-none-eabi-gcc: Command not found" may appear - it's OK, doesn't affect anything.


Remove the app from the device:
```bash
make delete
```

Enable debug mode:
```bash
make clean DEBUG=1 load
```

## Documentation
This follows the specification available in the [`tonapp.asc`](https://github.com/newton-blockchain/ledger-app-ton/blob/main/doc/tonapp.asc)
