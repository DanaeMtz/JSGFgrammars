pip3 install pyyaml

fct_yaml() {
    python3 -c "import yaml;print(yaml.safe_load(open('$1'))$2)"
}


export PYTHONPATH=$PWD
script_path="$(dirname "$0")"
nlu_resources=$(dirname $( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P ))
config_path=config/non_production/development.yaml
if ! test -f "$config_path"; then
  config_path="$nlu_resources/$config_path"
fi
nlu_resources_cfg=$(fct_yaml $config_path "['nlu-resources']")

lang="$(python3 -c "print($nlu_resources_cfg.get('language'))")"
if [ -z "$lang" ] || [ "$lang" == "None" ]; then
  lang=fr
fi

export COUNT="$(python3 -c "print($nlu_resources_cfg.get('count'))")"
if [ -z "$COUNT" ] || [ "$COUNT" == "None" ] || [ "$COUNT" == "CHANGE_ME" ]; then
  export COUNT=150
fi

export OUTPUT_PATH="$(python3 -c "print($nlu_resources_cfg.get('output_path'))")"
if [ -z "$OUTPUT_PATH" ] || [ "$OUTPUT_PATH" == "None" ]; then
  export OUTPUT_PATH="$nlu_resources/../nlu-tool/trsx/builder/resources"
fi

export GRAMMAR_PATH=$nlu_resources/grammars/jsgf/$lang
export DICT_PATH=$nlu_resources/grammars/jsgf/$lang/dicts
export HP_PATH=$nlu_resources/happy-paths/$lang
export JSGF_GEN=$nlu_resources/../jsgf-gen/build/install/jsgf-gen/bin/jsgf-gen

$script_path/common_expand.sh