namespace: HKEnablement-Demo
flow:
  name: calc_conversion_main_3
  inputs:
    - acres_input
  workflow:
    - calc_conversion2:
        do:
          HKEnablement-Demo.calc_conversion2:
            - acres_input: '${acres_input}'
        publish:
          - square_meters_output: '${param}'
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: CUSTOM
          - FAILURE: on_failure
  outputs:
    - square_meters: '${square_meters_output}'
  results:
    - SUCCESS
    - CUSTOM
    - FAILURE
extensions:
  graph:
    steps:
      calc_conversion2:
        x: 276
        'y': 250
        navigate:
          48a6e53b-1d39-0ecc-44a6-f96df560c5ea:
            targetId: 193199e3-f86d-1d8f-abe6-f6c3fd643d1d
            port: SUCCESS
          5ac3dffb-0d50-c076-8c6c-8d6397972158:
            targetId: 05fbd59f-92f2-b41b-11dd-5d83a68ea6a1
            port: WARNING
    results:
      SUCCESS:
        193199e3-f86d-1d8f-abe6-f6c3fd643d1d:
          x: 524
          'y': 210
      CUSTOM:
        05fbd59f-92f2-b41b-11dd-5d83a68ea6a1:
          x: 503
          'y': 333
