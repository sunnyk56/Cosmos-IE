# onomy artifacts
ONOMY=onomyd
# onomy artifacts
CHAIN_PROTOCOL=onomy
# onomy home directory
ONOMY_HOME=$HOME/.onomy
# Keyring flag
ONOMY_KEYRING_FLAG="--keyring-backend test"

echo "--------------get clone_exporter repo ---------------------------"
EXPORTER_DIR=$GOPATH/src/github.com/Cosmos-IE
git clone https://github.com/sunnyk56/Cosmos-IE.git $EXPORTER_DIR

echo "--------------get validator name and validator operator address ---------------------------"
ONOMY_VALIDATOR_NAME=$(jq -r .name $ONOMY_HOME/validator_key.json)
ONOMY_VALIDATOR_OPERATOR_ADDRESS=$($ONOMY keys show $ONOMY_VALIDATOR_NAME --bech val --address $ONOMY_KEYRING_FLAG)
echo "validator name:- $ONOMY_VALIDATOR_NAME"
echo "validator operator address:- $ONOMY_VALIDATOR_OPERATOR_ADDRESS"


echo "--------------create build ---------------------------"
cd $EXPORTER_DIR
go build

echo "--------------run the exporter ---------------------------"
./Cosmos-IE run --chain $CHAIN_PROTOCOL --oper-addr $ONOMY_VALIDATOR_OPERATOR_ADDRESS --port 9100
