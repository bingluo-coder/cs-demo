namespace: io.cloudslang.demos.amazon
flow:
  name: invoke_lambda
  inputs:
    - function
    - instance_id
    - ip_address
  workflow:
    - invoke_lambda:
        do:
          io.cloudslang.amazon.aws.lambda.invoke_lambda:
            - identity: "${get_sp('amazon.identity')}"
            - credential:
                value: "${get_sp('amazon.credential')}"
                sensitive: true
            - region: "${get_sp('amazon.availability_zone')}"
            - function: '${function}'
            - function_payload: "${'{\"instance_id\": \"' + instance_id + '\",\"sg_id\": \"' + get_sp('amazon.security_group_target') + '\",\"ip_address\": \"' + ip_address + '\"}'}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      invoke_lambda:
        x: 66
        y: 177
        navigate:
          c0453826-828d-94de-1e9f-f6961e2c0371:
            targetId: 8f0f8b91-ccbd-905c-8960-1957d0c3f50b
            port: SUCCESS
    results:
      SUCCESS:
        8f0f8b91-ccbd-905c-8960-1957d0c3f50b:
          x: 325
          y: 181
