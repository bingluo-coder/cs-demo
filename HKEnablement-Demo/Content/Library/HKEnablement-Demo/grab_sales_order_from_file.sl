namespace: HKEnablement-Demo
flow:
  name: grab_sales_order_from_file
  inputs:
    - file_path: "C:\\order_list.txt"
  workflow:
    - read_from_file:
        do:
          io.cloudslang.base.filesystem.read_from_file:
            - file_path: '${file_path}'
        publish:
          - read_text
          - message
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - read_text: '${read_text}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      read_from_file:
        x: 315
        'y': 177
        navigate:
          796f07d6-afbe-ebc6-bdbe-cd0dae7af180:
            targetId: f1fa8c4a-ae8c-c683-25bf-82e2be2a6f0e
            port: SUCCESS
    results:
      SUCCESS:
        f1fa8c4a-ae8c-c683-25bf-82e2be2a6f0e:
          x: 619
          'y': 177
