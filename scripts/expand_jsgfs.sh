script_path="$(dirname "$0")"
nlu_resources="$script_path/.."
lang=en
export COUNT=150

if [ "$#" -ge 1 ]; then
    lang=$1
fi

export GRAMMAR_PATH=$nlu_resources/grammars/jsgf/$lang
export DICT_PATH=$nlu_resources/grammars/jsgf/$lang/dicts
export HP_PATH=$nlu_resources/happy-paths/$lang
export OUTPUT_PATH=$nlu_resources/../nlu-tool/trsx/builder/resources
export JSGF_GEN=$nlu_resources/../jsgf-gen/build/install/jsgf-gen/bin/jsgf-gen

$script_path/common_expand.sh