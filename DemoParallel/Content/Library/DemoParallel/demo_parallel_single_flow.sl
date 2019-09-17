########################################################################################################################
#!!
#! @input IP_LIST: IP LIST of Ping IP Address
#!!#
########################################################################################################################
namespace: DemoParallel
flow:
  name: demo_parallel_single_flow
  inputs:
    - IP_LIST: '16.43.99.104,16.43.98.35,16.43.98.32'
  workflow:
    - local_ping:
        parallel_loop:
          for: IP in IP_LIST
          do:
            io.cloudslang.base.utils.local_ping:
              - target_host: '${IP}'
        publish:
          - pingResult: |-
              ${str([str(x["branch_result"])
              for x in branches_context])}
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      local_ping:
        x: 100
        'y': 250
        navigate:
          e23e60fd-f14f-e46c-1dc4-9d92761eb095:
            targetId: 13b5f3d4-7188-cf61-e9bf-a27b43b30dbd
            port: SUCCESS
          f4d42075-ae3e-694d-421f-6ec24e971b81:
            targetId: 752a0b13-d87c-15ec-c2c0-bf9b09f22598
            port: FAILURE
    results:
      FAILURE:
        752a0b13-d87c-15ec-c2c0-bf9b09f22598:
          x: 400
          'y': 375
      SUCCESS:
        13b5f3d4-7188-cf61-e9bf-a27b43b30dbd:
          x: 400
          'y': 125
