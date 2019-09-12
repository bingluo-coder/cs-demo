namespace: HKEnablement-Demo
flow:
  name: calc_conversion_main
  inputs:
    - acres_input: '7'
  workflow:
    - calc_conversion:
        do:
          HKEnablement-Demo.calc_conversion:
            - acres_input: '${acres_input}'
        publish:
          - square_meters_output
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: CUSTOM
          - FAILURE: on_failure
  outputs:
    - square_meters: '${square_meters_output}'
  results:
    - FAILURE
    - SUCCESS
    - CUSTOM
extensions:
  graph:
    steps:
      calc_conversion:
        x: 233
        'y': 221
        navigate:
          bf6acafb-8fca-2269-d04a-5e9b99a4e6d4:
            targetId: 193199e3-f86d-1d8f-abe6-f6c3fd643d1d
            port: SUCCESS
            vertices: []
          5005c40c-53f1-62d9-8c66-8b23b83e3f7f:
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
