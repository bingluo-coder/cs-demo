#   (c) Copyright 2015-2017 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################################
#!!
#! @description: generate random password
#!
#! @result SUCCESS: good python stuff
#!!#
########################################################################################################################

namespace: io.cloudslang.demos.utils

operation:
  name: generate_random

  python_action:
    script: |
      import string
      from random import *
      characters = string.ascii_letters + string.punctuation  + string.digits
      password =  "".join(choice(characters) for x in range(randint(8, 16)))

  outputs:
    - return_result: ${password}

  results:
    - SUCCESS
