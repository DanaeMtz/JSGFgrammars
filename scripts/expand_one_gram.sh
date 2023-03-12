# ! bin/bash 
INTENT=$1
LAN=$2
case $INTENT in 
	"manage_payee" | "pay_bill" | "stop_recurring_payment")
	build/install/jsgf-gen/bin/jsgf-gen ... --grammar grammars/jsgf/$LAN/$INTENT.gram --count 150 | tee outputs/$LAN/$INTENT.utt | sort | less ;;
	*)
	build/install/jsgf-gen/bin/jsgf-gen ... --grammar grammars/jsgf/$LAN/$INTENT.gram --count 150 --tags | tee outputs/$LAN/$INTENT.utt | sort | less ;;
esac

