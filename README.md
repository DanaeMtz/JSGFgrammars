# NLU resources
This repository contains the resources (i.e., grammars and dictionaries) used to generate artificial data (utterances) in order to train/test our NLU models.

These resources follow the Java Speech Grammar Format, in short, [JSGF](https://www.w3.org/TR/jsgf).

## Usage
In order to obtain the actual utterances, the grammars need to be expanded.

By using the tool [jsgf-gen](https://github.com/synesthesiam/jsgf-gen), with the command `jsgf-gen --grammar basic_command.gram --count 5  --tags`, the following grammar:


```
#JSGF V1.0;
grammar basic_command;

public <basic_command> = [<politeness>] <command>;

<command> = <action> <object>;
<action> = (open | close) {action};
<object> = [the | a] (window | file) {object};

<politeness> = (/2/ please | /1/ could you [please]); 
```

can be expanded into the following utterances:

```
could you [close](action) [file](object)
[close](action) [file](object)
[open](action) the [file](object)
[open](action) [file](object)
could you [open](action) [file](object)
``` 

Where (action) and (object) are the annotations/tags of the entities, defined in the grammar as {action} and {object}, respectively. 

Please refer to [JSGF](https://www.w3.org/TR/jsgf) and [jsgf-gen](https://github.com/synesthesiam/jsgf-gen) to learn more on the JSGF features.


## Repository Structure

```
├── grammars         # Folder containing the grammars and dictionaries
│	├── en           # Folder containing the grammars for generating English utterances. There is one grammar per intent
│	│	├── dicts    # Dictionaries employed by the English grammars
├── README.md
└── .gitignore
```

## Action verbs par intent 

| Intent     | Verb in French |
|------------|------------|
| Invest  | déposer, mettre, placer, déplacer, épargner |

