#!/usr/bin/python3

import sys, yaml

with open(sys.argv[1], "r") as fp:
    lexicon = fp.read()

print(yaml.dump(yaml.load(lexicon), allow_unicode=True))
