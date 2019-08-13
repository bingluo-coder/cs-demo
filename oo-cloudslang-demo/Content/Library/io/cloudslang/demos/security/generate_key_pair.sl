########################################################################################################################
#!!
#! @description: generates a random key_pair, one of them with a timestamp characteristic
#!
#! @output private_key: to be saved as secret
#!!#
########################################################################################################################
namespace: io.cloudslang.demos.security
flow:
  name: generate_key_pair
  workflow:
    - generate_random:
        do:
          io.cloudslang.demos.utils.generate_random: []
        publish:
          - return_result: EGEg4we12XrH
        navigate:
          - SUCCESS: get_time
    - get_time:
        do:
          io.cloudslang.base.datetime.get_time:
            - locale_lang: unix
        publish:
          - timestamp: '${output}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  outputs:
    - private_key: "${return_result+'time'+timestamp}"
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      generate_random:
        x: 100
        y: 250
      get_time:
        x: 400
        y: 250
        navigate:
          111f61c7-2c99-2db2-f2aa-f240f82b6546:
            targetId: 43ef0412-330c-d719-d6c9-c659812dc5c7
            port: SUCCESS
          185c2694-a589-0812-2438-3ab8ad7ef542:
            targetId: 91b2ddd9-d641-d8fe-e964-53cc36dcd2a8
            port: FAILURE
    results:
      SUCCESS:
        43ef0412-330c-d719-d6c9-c659812dc5c7:
          x: 700
          y: 125
      FAILURE:
        91b2ddd9-d641-d8fe-e964-53cc36dcd2a8:
          x: 700
          y: 375
