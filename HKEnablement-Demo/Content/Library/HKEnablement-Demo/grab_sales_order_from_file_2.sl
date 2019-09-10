namespace: HKEnablement-Demo
flow:
  name: grab_sales_order_from_file_2
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
          - SUCCESS: post_message
          - FAILURE: on_failure
    - post_message:
        do:
          io.cloudslang.demos.slack.chat.post_message:
            - token: "${get_sp('slack.token')}"
            - channel: "${get_sp('slack.channel')}"
            - text: '${read_text}'
            - attachments: null
            - proxy_host: "${get_sp('proxy_host')}"
            - proxy_port: "${get_sp('proxy_port')}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - read_text: '${read_text}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      read_from_file:
        x: 100
        'y': 150
      post_message:
        x: 400
        'y': 150
        navigate:
          65ccf183-59f8-a251-5806-41581ce80fa2:
            targetId: 74e444a7-2c77-56b5-a014-687c2b3fcbb9
            port: SUCCESS
    results:
      SUCCESS:
        74e444a7-2c77-56b5-a014-687c2b3fcbb9:
          x: 624
          'y': 155
