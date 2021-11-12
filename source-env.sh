# find out how the script was invoked
# we don't want to end the user's terminal session!
if [[ "$0" != "$BASH_SOURCE" ]] ; then
  # this script is executed via `source`!
  # An `exit` will close the user's console!
  EXIT=return
else
  # this script is not `source`-d, it's safe to exit via `exit`
  EXIT=exit
fi

if [ $# -ne 1 ]; then
    echo "Possible options: s or x"
    $EXIT 1
elif [[ $1 == "-h" ]]; then
    $EXIT "Possible options: s or x"
    exit 1
elif [[ $1 != "s" ]] && [[ $1 != "x" ]]; then
    echo "Possible options: blue, s or x"
    $EXIT 1
fi

source dev-env/ledger_py3/bin/activate &&

if [[ $1 == "s" ]]; then
    export BOLOS_SDK=$(pwd)/dev-env/SDK/nanos-secure-sdk
    export BOLOS_ENV=$(pwd)/dev-env/CC/others
elif [[ $1 == "x" ]]; then
    export BOLOS_SDK=$(pwd)/dev-env/SDK/nanox-secure-sdk
    export BOLOS_ENV=$(pwd)/dev-env/CC/nanox
fi
