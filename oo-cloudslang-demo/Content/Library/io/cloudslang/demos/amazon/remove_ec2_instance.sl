namespace: io.cloudslang.demos.amazon
flow:
  name: remove_ec2_instance
  inputs:
    - instance_id: i-081e2c98b20251727
  workflow:
    - undeploy_instance:
        do:
          io.cloudslang.amazon.aws.ec2.undeploy_instance:
            - identity: "${get_sp('amazon.identity')}"
            - credential: "${get_sp('amazon.credential')}"
            - instance_id: '${instance_id}'
        publish:
          - exception
          - output
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - output: '${output}'
    - exception: '${exception}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      undeploy_instance:
        x: 110
        y: 126
        navigate:
          9798a540-b1da-f45e-f160-93b5292ba1e2:
            targetId: bb06b886-3536-9f64-9845-993fa44d2168
            port: SUCCESS
    results:
      SUCCESS:
        bb06b886-3536-9f64-9845-993fa44d2168:
          x: 311
          y: 129
