########################################################################################################################
#!!
#! @input IP: Ip to ping
#! @input TIMEOUT: timeout to ping
#!!#
########################################################################################################################
namespace: DemoParallel.subflow
flow:
  name: ping_subflow
  inputs:
    - IP: localhost
    - TIMEOUT: '5000'
  workflow:
    - local_ping:
        do:
          io.cloudslang.base.utils.local_ping:
            - target_host: '${IP}'
            - timeout: '${TIMEOUT}'
        publish:
          - pingResult: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  outputs:
    - returnResult: '${pingResult}'
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
