########################################################################################################################
#!!
#! @input IP_LIST: IP LIST of Ping IP Address
#!!#
########################################################################################################################
namespace: DemoParallel
flow:
  name: demo_parallel_subflow
  inputs:
    - IP_LIST: '16.43.99.104,16.43.98.35,16.43.98.32'
  workflow:
    - ping_subflow:
        parallel_loop:
          for: IP in IP_LIST
          do:
            DemoParallel.subflow.ping_subflow:
              - IP: '${IP}'
        publish:
          - returnResults: |-
              ${str([str(x["returnResult"])
              for x in branches_context])}
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: SUCCESS
  outputs:
    - returnResult: '${returnResults}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ping_subflow:
        x: 175
        'y': 279
        navigate:
          fa9623e5-1c40-cbfd-5f8b-ec0c0e86c4de:
            targetId: 752a0b13-d87c-15ec-c2c0-bf9b09f22598
            port: FAILURE
          3a050b72-bd5c-91aa-f9fe-3ebb16d617dc:
            targetId: d02335b6-9b1c-0b8d-423f-d1eefc921452
            port: SUCCESS
    results:
      FAILURE:
        752a0b13-d87c-15ec-c2c0-bf9b09f22598:
          x: 605
          'y': 500
      SUCCESS:
        d02335b6-9b1c-0b8d-423f-d1eefc921452:
          x: 618
          'y': 148
