mkdir -p $OUTPUT_PATH/"happy-paths"
rm $OUTPUT_PATH/*.utt 2> /dev/null
rm $OUTPUT_PATH/happy-paths/*.utt 2> /dev/null

add_intent_to_error (){
    printf "$error_prefix $1\n" >> $error_tmp_path
}

grammars=`ls $GRAMMAR_PATH/*.gram | xargs -n1 basename | sed -r 's/.gram//'`
error_prefix="in jsgf"
error_tmp_path=/tmp/JSGF_ERROR_OUT

echo "Expanding grammars and copying them to $OUTPUT_PATH"

for INTENT in $grammars
do
  echo $INTENT
  case $INTENT in
    "manage_payee" | "pay_bill" | "stop_recurring_payment")
      # we dont want the tags for these intents
      $JSGF_GEN --grammar $GRAMMAR_PATH/$INTENT.gram --count $COUNT > $OUTPUT_PATH/$INTENT.utt 2>> $error_tmp_path || add_intent_to_error $INTENT
    ;;
    *)
      $JSGF_GEN --grammar $GRAMMAR_PATH/$INTENT.gram --count $COUNT --tags > $OUTPUT_PATH/$INTENT.utt 2>> $error_tmp_path || add_intent_to_error $INTENT
    ;;
  esac
done

dicts=`ls $DICT_PATH/*.gram | xargs -n1 basename | sed -r 's/.gram//'`
echo "Expanding dictionaries and copying them to $OUTPUT_PATH"
for DICT in $dicts
do
  echo $DICT
  $JSGF_GEN --grammar $DICT_PATH/$DICT.gram --exhaustive --tags > $OUTPUT_PATH/$DICT.utt 2>> $error_tmp_path || add_intent_to_error $DICT
done
echo "done"

echo "Copying happy-paths to" $OUTPUT_PATH/"happy-paths"
cp $HP_PATH/*.utt $OUTPUT_PATH/"happy-paths"/
echo "done"


error_logs=$(grep -v "dumpStatistics\|INFO:" $error_tmp_path )
if [[ ! -z $error_logs ]] ; then
    printf "\n######################################################\n\n $error_logs\n"
fi

rm $error_tmp_path
