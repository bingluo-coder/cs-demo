namespace: Salesforce
flow:
  name: Order_flow
  inputs:
    - username: robin2056-sfb4@force.com
    - password:
        default: 'vf!qaP59Fbgguaz'
        sensitive: true
    - account_name: Facebook
    - order_date: '2019-9-17'
    - contract_number: '00000103'
    - description: Order for Facebook
  workflow:
    - Order:
        do:
          Salesforce.Order:
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - account_name: '${account_name}'
            - order_date: '${order_date}'
            - contract_number: '${contract_number}'
            - description: '${description}'
        publish:
          - order_number: '${order_number.split()[1]}'
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - order_number
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Order:
        x: 101
        'y': 150
        navigate:
          191bd93a-2ab2-96cf-f7f3-c7c88b186675:
            targetId: cae466b2-4703-556e-a6dc-d4d1f1d4d925
            port: SUCCESS
          d995af1e-c71e-dd0b-c6ad-bf0df577fb22:
            targetId: cae466b2-4703-556e-a6dc-d4d1f1d4d925
            port: WARNING
    results:
      SUCCESS:
        cae466b2-4703-556e-a6dc-d4d1f1d4d925:
          x: 400
          'y': 150
