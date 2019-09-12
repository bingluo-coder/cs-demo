namespace: HKEnablement-Demo
flow:
  name: calc_conversion_main_4
  workflow:
    - calc_conversion4:
        do:
          HKEnablement-Demo.calc_conversion4: []
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
      calc_conversion4:
        x: 265
        'y': 237
        navigate:
          c2d05614-ce8d-79bb-4807-c696a2a91c10:
            targetId: 193199e3-f86d-1d8f-abe6-f6c3fd643d1d
            port: SUCCESS
          c53d112f-5ac8-32a4-613a-0df4f44a24b8:
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
